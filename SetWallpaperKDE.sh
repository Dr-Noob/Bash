#!/bin/bash -u
#THIS SCRIPT WORKS ONLY IF YOU'RE USING KDE
##############################################
##KDE script to change the desktop wallpaper##
##############################################
#To get this script working, you first need to change the default behaviour of
#KDE Wallpaper. In appearance settings, set "Type of desktop background" to
#slideshowk, and set the folder where you want to copy a temporary wallpaper image

RED="\033[1;31m"
RESET="\033[0m"

if [ $# -eq 1 ]
then
	if [ $1 == "-h" ]
	then
		echo 'Showing help: '
		echo 'To get this script working, you first need to change the default behaviour of KDE Wallpaper.In appearance settings, set "Type of desktop background" to slideshowk, and set the folder where you want to copy a temporary wallpaper image'
		exit 0
	fi
fi

if [ $# -ne 2 ]
then
	echo -e $RED'ERROR: This script needs two arguments: '
	echo -e $0' new_wallpaper tmp_folder'
	echo -e 'Please run '$0 '-h'$RESET
	exit 1
fi

if [ ! -d "$2" ]
then
  echo -e $RED'ERROR: Folder '$2' does not exist'
  echo -e 'You need to create it and change KDE settings to get this script working'
  echo -e 'Please run '$0 '-h'$RESET
	exit 1
fi

if [ ! -f $1 ]
then
  echo -e $RED'ERROR: File '$1' does not exist'
  echo -e 'You need to specify a valid wallpaper'
  echo -e 'Please run '$0 '-h'$RESET
	exit 1
fi

rm -fr $2/{*,.*} 2> /dev/null > /dev/null
if [[ $(ls -A $2) ]]
then
	echo 'Something went wrong when deleting content of '$2
	exit 1
fi

cp $1 $2
if [ $? -ne 0 ]
then
	echo 'Something went wrong when copying '$1' to '$2
	exit 1
fi

echo 'The wallpaper '$1' was sucessfully set'
