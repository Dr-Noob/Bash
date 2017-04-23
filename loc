#!/bin/bash
###############################
#       Lines Of Code in a directory(recursively)       #
###############################

RED="\x1b[1;31m"
RESET="\x1b[0;0m"

if [ $# -ne 1 ]
then
	echo -e $RED'Missing a directory'$RESET
	echo 'Usage: '$0' directory'
	exit 1
fi

if [[ ! -d $1 ]]
then
	echo -e $RED$1' is not a directory'$RESET
	exit 1
fi

DIR=$1
COUNTER=0

for c in $(find $DIR -type f)
do

	let COUNTER=COUNTER+$(wc -l $c | cut -d' ' -f1)

done

echo 'There are '$COUNTER' lines in '$DIR

