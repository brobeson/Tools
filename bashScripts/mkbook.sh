#!/bin/bash

error=0
version="2015.01.12"

function print_help
{
	echo "NAME"
	echo "    $script_name - compile an EPUB file from content"
	echo
	echo "SYNOPSIS"
	echo "    $script_name [OPTIONS] [DIRECTORY]"
	echo
	echo "DESCRIPTION"
	echo "    DIRECTORY should be the path to the root of the content. If DIRECTORY is"
	echo "    omitted, the current working directory is used."
	echo
	echo "    -h --help"
	echo "        Print this help and exit."
	echo
	echo "    -v --version"
	echo "        Print the script version and exit."
}


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

function check_is_directory
{
	if [[ ! -d $1 ]]
	then
		PrintError "$1 is not a directory"
		error=1
	fi
}

#=================================================
# parse the command options and check for errors
#=================================================
script_name=${0##.*/}
options=$(getopt --options hv --longoptions help,version --name ${script_name} -- "$@")
eval set -- "$options"
while [[ $1 != "--" ]]
do
	case "$1" in
		-h|--help)		print_help
						exit 0
						;;
		-v|--version)	echo $version
						exit 0
						;;
		#--epub-version)	echo "--epub-version is not yet implemented"
		#				shift
		#				;;
		*)				PrintError "unknown argument $1"
						exit 1
						;;
	esac
done

# process the positional parameters:
# 1st is the --
# 2nd (optional) is the root directory of the EPUB content
if [[ $# == 2 ]]
then
	directory=$2
else
	directory=$(pwd)
fi

# check if the content directory exists, and is a directory
if [[ ! -d $directory ]]
then
	PrintError "$directory is not a directory"
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

