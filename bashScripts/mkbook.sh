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


function print_error
{
	echo "error - " $1
}

function check_exists
{
	if [[ ! -e $1 ]]
	then
		print_error "cannot find $1"
		error=1
	fi
}

function check_is_directory
{
	if [[ ! -d $1 ]]
	then
		print_error "$1 is not a directory"
		error=1
	fi
}

#=================================================
# parse the command options and check for errors
#=================================================
script_name=$(basename --suffix=.sh "$0")
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
		*)				print_error "unknown argument $1"
						exit 1
						;;
	esac
done

# process the positional parameters:
# 1st is the --
# 2nd (optional) is the root directory of the EPUB content
directory=${2-$(pwd)}
directory=${directory%%/}

# check if some required directories and files exist
check_is_directory $directory
check_is_directory $directory/META-INF
check_exists $directory/META-INF/container.xml

epubFile=${directory##*/}.epub
# TODO	finished here
echo $epubFile
exit 0
check_exists $directory/../$epubFile

if [[ $error != 0 ]]
then
	exit 1
fi

# if the mimetype is not present, we can attempt to create it
customMimetype=0
if [[ ! -e $directory/mimetype ]]
then
	customMimetype=1
	echo "application/epub+zip" > $directory/mimetype
	check_exists $directory/mimetype
	if [[ error != 0 ]]
	then
		exit 1
	fi
fi

