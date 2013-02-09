#!/bin/bash

PIPE=/tmp/autotoum_$$
ATOUM=bin/atoum
SOURCES="$(pwd)/src $(pwd)/tests/units"
QUIET=false

if [ "-h" = "$1" ]
then	
	echo -e " Usage : $0 [-q] [\e[0;32m<path/to/atoum>\e[0m] [\e[0;32m<path/to/tests>\e[0m]"
	echo
	echo -e "     Path to atoum : defaults to \e[0;32m$ATOUM\e[0m"
	echo -e "     Path to sources : defaults to \e[0;32m$SOURCES\e[0m"
	echo
	echo -e "     You can specify several files/directories to watch using a \e[0;comma (,) separated list\e[0m :"
	echo -e "         $ autotoum bin/atoum src,tests/units/subset,tests/units/otherSubset"
	echo
	echo -e "     Use CTRL+C to quit"
fi
 
if [ ! $(which kicker) ]
then
	echo -e " \e[0,31mkicker is not available. Consider installing kicker's gem\e[0m"
	exit 1
fi

[ "-h" = "$1" ] && exit 0
 
if [ ! -z "$1" ]
then
	ATOUM=$1
fi

[ ! -z "$2" ] && SOURCES=$(echo $2 | sed "s/,/ /g")

[[ -p $PIPE ]] && rm $PIPE; mkfifo $PIPE

kicktrap() { kill %%; }
trap kicktrap INT
kicker -s -e "echo > $PIPE" $SOURCES > /dev/null 2>&1 &

while true 
do 
	if read line < $PIPE
	then  
		echo			
	fi
done | bin/atoum --test-all --loop
