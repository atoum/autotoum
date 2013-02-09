#!/bin/bash

if [ "-h" = "$1" ]
then	
	echo -e " Usage : $0 [\e[0;32m<path/to/atoum>\e[0m] [\e[0;32m<path/to/tests>\e[0m]"
	echo
	echo -e "     Path to atoum : defaults to \e[0;32mbin/atoum\e[0m"
	echo -e "     Path to sources : defaults to \e[0;32msrc,tests/units\e[0m"
	echo
	echo -e "     You can specify several files/directories to watch using a \e[0;32mcomma (,) separated list\e[0m :"
	echo -e "         $ autotoum bin/atoum src,tests/units/subset,tests/units/otherSubset"
	echo
	echo -e "     Use CTRL+C to quit"
fi

if [ ! $(which inotifywait) ]
then
	echo 'inotifywait is not available. Consider installing inotify-tools'
	exit 1
fi

[ "-h" = "$1" ] && exit 0

if [ ! -z "$1" ]
then	
	ATOUM=$1
fi

if [ ! -z "$2" ]
then		
	SOURCES=$2
fi

[ -z "$ATOUM" ] && ATOUM=bin/atoum
[ -z "$SOURCES" ] && SOURCES="$(pwd)/src,$(pwd)/tests/units"

OIFS=$IFS
IFS=','
WATCHLIST="/tmp/autotoum_$$"
for x in $SOURCES
do
    echo $x >> $WATCHLIST
done
IFS=$OIFS

[ ! -x "$ATOUM" ] && echo "File $ATOUM does not exist or is not executable" && exit 1

while inotifywait -re close_write,moved_to,create --fromfile $WATCHLIST > /dev/null 2>&1
do 
    echo 
done | $ATOUM --test-all --loop

rm -f $WATCHLIST