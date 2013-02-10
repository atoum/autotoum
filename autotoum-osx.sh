#!/bin/bash

PIPE=/tmp/autotoum_$$
ATOUM=bin/atoum
SOURCES="$(pwd)/src $(pwd)/tests/units"
TESTS="--test-all"

check() {
	if [ ! $(which kicker) ]
	then
		echo -e " kicker is not available. Consider installing kicker's gem"
		exit 1
	fi
}

usage() {
	echo -ne " Usage : $(basename $0) [-b path/to/atoum] [-w path/to/sources] [-t path/to/tests/units]"
	echo
	echo -e "     Path to atoum : path to atoum executable (defaults to $ATOUM)"
	echo -e "     Path to sources : the watched files and/or directories (defaults to $SOURCES)"
	echo -e "     Extra arguments : Extra arguments are forwarded to the atoum executable"
	echo
	echo -e "     You can specify several files/directories to watch using a comma (,) separated list :"
	echo -e "         $ autotoum -w src,tests/units/subset,tests/units/otherSubset -- -d tests/units"
	echo
	echo -e "     Use CTRL+C to quit"

	check
}
 
while getopts “hb:w:” OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        b)
            ATOUM=$OPTARG
            ;;
        w)
            SOURCES=$(echo $OPTARG | sed "s/,/ /g")
            for entry in $SOURCES
            do
                if [ ! -d $entry ] && [ ! -f $entry ]
                then
                    echo "Directory/File $entry does not exist"
                    exit 1
                fi
            done
            ;;
        ?)
            usage
            exit 1
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

shift $(expr $OPTIND - 1)

check

[ ! -x $ATOUM ] && echo "Cannot run $ATOUM" && exit 1

[[ -p $PIPE ]] && rm $PIPE; mkfifo $PIPE

kicktrap() { kill %%; }
trap kicktrap INT
kicker -l 0 -s -e "echo > $PIPE" $SOURCES > /dev/null 2>&1 &

LOOP=false
while true 
do 
	if read line < $PIPE
	then  
		if $LOOP
		then
			echo			
		else
			LOOP=true
		fi
	fi
done | $ATOUM $TESTS $* --loop
