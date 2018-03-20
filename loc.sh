#!/bin/bash -u
#########################################################
#       Lines Of Code in a directory(recursively)       #
#########################################################

#Global vars
n0_1="          "
n0_2="          "
n0_3="  #####   "
n0_4=" ##   ##  "
n0_5="##     ## "
n0_6=" ##   ##  "
n0_7="  #####   "
n0_8="          "
n0_9="          "

n1_1="          "
n1_2="          "
n1_3="   ##     "
n1_4=" ####     "
n1_5="   ##     "
n1_6="   ##     "
n1_7=" ######   "
n1_8="          "
n1_9="          "

n2_1="          "
n2_2="          "
n2_3=" #######  "
n2_4="##     ## "
n2_5="   #####  "
n2_6="##        "
n2_7="######### "
n2_8="          "
n2_9="          "

n3_1="          "
n3_2="          "
n3_3=" #######  "
n3_4="##     ## "
n3_5="   #####  "
n3_6="##     ## "
n3_7=" #######  "
n3_8="          "
n3_9="          "

n4_1="          "
n4_2="          "
n4_3="##        "
n4_4="##    ##  "
n4_5="######### "
n4_6="      ##  "
n4_7="      ##  "
n4_8="          "
n4_9="          "

n5_1="         "
n5_2="         "
n5_3="######## "
n5_4="##       "
n5_5=" ######  "
n5_6="     ### "
n5_7="#######  "
n5_8="         "
n5_9="         "

n6_1="          "
n6_2="          "
n6_3=" #######  "
n6_4="##        "
n6_5="########  "
n6_6="##     ## "
n6_7=" #######  "
n6_8="          "
n6_9="          "

n7_1="         "
n7_2="         "
n7_3="######## "
n7_4="##    ## "
n7_5="    ##   "
n7_6="  ##     "
n7_7="  ##     "
n7_8="         "
n7_9="         "

n8_1="          "
n8_2="          "
n8_3=" #######  "
n8_4="##     ## "
n8_5=" #######  "
n8_6="##     ## "
n8_7=" #######  "
n8_8="          "
n8_9="          "

n9_1="          "
n9_2="          "
n9_3=" #######  "
n9_4=" ##   ##  "
n9_5=" #######  "
n9_6="      ##  "
n9_7=" #######  "
n9_8="          "
n9_9="          "

nCPP_ASCII_1="             ******                       "
nCPP_ASCII_2="            **////**      *          *    "
nCPP_ASCII_3="           **    //      /*         /*    "
nCPP_ASCII_4="          /**         *********  *********"
nCPP_ASCII_5="          /**        /////*///  /////*/// "
nCPP_ASCII_6="          //**    **     /*         /*    "
nCPP_ASCII_7="           //******      /          /     "
nCPP_ASCII_8="            //////                        "
nCPP_ASCII_9="                                          "

nL_ASCII_1="                                         "
nL_ASCII_2="              _                          "
nL_ASCII_3="           \_|_)                         "
nL_ASCII_4="             |      __,   _|_   _        "
nL_ASCII_5="            _|     /  |    |   |/   /\/  "
nL_ASCII_6="           (/\___/ \_/|_/  |_/ |__/  /\_/"
nL_ASCII_7="                                         "
nL_ASCII_8="                                         "
nL_ASCII_9="                                         "

RED="\x1b[1;31m"
RESET="\x1b[0;0m"

#Functions
function print_numeros {
	for n in $(seq 1 9)
	do

		for var in "$@"
		do
			pr="n"$var"_"$n
			printf "${!pr}"
		done

	printf "\n"

	done
}

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
	args=$(echo "$C_C" | fold -w1 | tr '\n' ' ')
	print_numeros $args "C_ASCII"
	CODEFOUND=true
fi

if [ "$CPP_C" -ne "0" ]; then
	args=$(echo "$CPP_C" | fold -w1 | tr '\n' ' ')
	print_numeros $args "CPP_ASCII"
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
	args=$(echo "$L_C" | fold -w1 | tr '\n' ' ')
	print_numeros $args "L_ASCII"
	CODEFOUND=true
fi

if ! $CODEFOUND ; then
	echo -e $RED'No code file found!'$RESET
fi
