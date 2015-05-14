#!/bin/sh

error=0

function PrintError
{
	echo "error - " $1
}

function CheckExistance
{
	if [[ ! -e $1 ]]
	then
		PrintError "cannot find $1"
		error=1
	fi
}

#==========================================
# error checking
#==========================================
# the directory is required as a command line argument
if [[ $# < 1 ]]
then
	PrintError "a source directory is required"
	exit 1
fi
directory=$1

# check if the source directory exists, and is a directory
CheckExistance $directory
if [[ ! -d $directory ]]
then
	PrintError "$1 is not a directory"
	exit 1
fi

# check that required contents exist
CheckExistance $directory/META-INF
CheckExistance $directory/META-INF/container.xml

epubFile=${directory##*/}.epub
CheckExistance $directory/../$epubFile

if [[ error != 0 ]]
then
	exit 1
fi

# if the mimetype is not present, we can attempt to create it
customMimetype=0
if [[ ! -e $directory/mimetype ]]
then
	customMimetype=1
	echo "application/epub+zip" > $directory/mimetype
	CheckExistance $directory/mimetype
	if [[ error != 0 ]]
	then
		exit 1
	fi
fi

