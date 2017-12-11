#!/bin/bash -u
#########################################################
#       Lines Of Code in a directory(recursively)       #
#########################################################

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

#Counters for different files
JAVA_C=0 			#JAVA
C_C=0					#C
CPP_C=0				#C++
H_C=0					#Headers
P_C=0					#Python
B_C=0					#Bash
L_C=0					#Latex
#Wait.Latex?Yes,Latex

#Files extension for different files(without dot)
JAVA_E="java"
C_E="c"
CPP_E="cpp"
HC_E="h"
HCPP_E="hpp"
P_E="py"
B_E="sh"
L_E="tex"

for c in $(find $DIR -type f)
do

	FILE=$(basename "$c")
	EXTENSION="${FILE##*.}"

	case "$EXTENSION" in
    "$JAVA_E")
        let JAVA_C=JAVA_C+$(wc -l $c | cut -d' ' -f1)
        ;;
		"$C_E")
        let C_C=C_C+$(wc -l $c | cut -d' ' -f1)
        ;;
		"$CPP_E")
				let CPP_C=CPP_C+$(wc -l $c | cut -d' ' -f1)
				;;
		"$HC_E" | "$HCPP_E")
				let H_C=H_C+$(wc -l $c | cut -d' ' -f1)
				;;
		"$P_E")
				let P_C=P_C+$(wc -l $c | cut -d' ' -f1)
				;;
		"$B_E")
				let B_C=B_C+$(wc -l $c | cut -d' ' -f1)
				;;
		"$L_E")
				let L_C=L_C+$(wc -l $c | cut -d' ' -f1)
				;;
    *)
        ;;
	esac

done
CODEFOUND=false

if [ "$JAVA_C" -ne "0" ]; then
	echo 'There are '$JAVA_C' Java lines'
	CODEFOUND=true
fi

if [ "$C_C" -ne "0" ]; then
	echo 'There are '$C_C' C lines'
	CODEFOUND=true
fi

if [ "$CPP_C" -ne "0" ]; then
	echo 'There are '$CPP_C' lines'
	CODEFOUND=true
fi

if [ "$H_C" -ne "0" ]; then
	echo 'There are '$H_C' Header lines'
	CODEFOUND=true
fi

if [ "$B_C" -ne "0" ]; then
	echo 'There are '$B_C' Bash lines'
	CODEFOUND=true
fi

if [ "$L_C" -ne "0" ]; then
	echo 'There are '$L_C' Latex lines'
	CODEFOUND=true
fi

if ! $CODEFOUND ; then
	echo -e $RED'No code file found!'$RESET
fi
