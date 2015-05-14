#!/bin/bash

error=0
version="2015.01.12"

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

#=================================================
# parse the command options and check for errors
#=================================================
#http://linuxaria.com/howto/parse-options-in-your-bash-script-with-getopt
#http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt
http://linux.die.net/man/1/getopt
options=`getopt --long version -- "$@"`
eval set -- "$options"
while true
do
	case "$1" in
		--version)
			echo $version
			exit 0
			shift;;
		--epub-version)
			echo "--epub-version is not yet implemented"
			shift;;
	esac
done

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

