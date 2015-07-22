#!/bin/bash

# set up some constants
CMD_LCE="lce"
CMD_REORIENT="reorient"

# display help information if it's needed
function help
{
	echo "NAME"
	echo "    $script_name - reorient a directory of photographs"
	echo
	echo "SYNOPSIS"
	echo "    $script_name COMMAND [OPTIONS] [DIRECTORY]"
	echo
	echo "DESCRIPTION"
	echo "    Reorient all the image files which are incorrectly oriented. Perform this"
	echo "    action on the files in the given DIRECTORY. If DIRECTORY is omitted, the"
	echo "    current working directory is used."
	echo
	echo "COMMANDS"
	echo "    Photos provides a few options for modifying pictures and photographs."
	echo "    The action to perform is specified with one of the following commands."
	echo
	echo "    $CMD_LC"
	echo "        Convert any filenames with upper case letters to lower case letters."
	echo
	echo "    $CMD_REORIENT"
	echo "        Automatically reorient pictures that are not oriented correctly. This"
	echo "        command requires that the pictures have appropriate metadata embedded"
	echo "        by the camera."
	echo
	echo "OPTIONS"
	echo
	echo "    --help"
	echo "        Display this help, then exit."
	echo
	echo "AUTHOR"
	echo "    Brendan Robeson (https://github.com/brobeson/tools)"
	echo
	echo "REPORTING BUGS"
	echo "    The best way is to open an issue at https://github.com/brobeson/tools. Please"
	echo "    include the script name ($script_name), in the issue."
	echo
	echo "COPYRIGHT"
	echo "    This script is placed in the public domain."
	echo
}


# handle the reorient command
function reorient
{
	#echo $file_list
	#for file_name in "${file_list[@]}"
	#do
	#	echo "mogrify -verbose -auto-orient $file_list"
	#done
}

# store off the script name for later use
script_name=${0##.*/}

# parse off the arguments
options=$(getopt --options hr --longoptions help,recursive --name ${script_name} -- "$@")
eval set -- "$options"

# process the options
while [[ $1 != "--" ]]
do
	case "$1" in
		-h|--help)		help
						exit 0
						;;
		-r|--recursive)	recursive=true
						shift
						;;
		*)				echo "unknown command options found"
						exit 1
						;;
	esac
done

# process the positional parameters:
# 1st is the --
# 2nd must be the command
# 3rd (optional) is the directory on which to operate
if [[ $# < 2 ]]
then
	echo "error: a command is required; try $script_name --help"
	exit 1
fi
cmd=$2
if [[ $# == 3 ]]
then
	directory=$3
else
	directory=$(pwd)
fi

# check that the directory exists and is valid
if [[ ! -d $directory ]]
then
	echo "error: $directory is not a directory"
fi

# fill the list of files on which to operate
if [[ $recursive == true ]]
then
	file_list=($(find $directory -type f \( -name "*.jpg" -or -name "*.tif" \)))
else
	file_list=($(ls $directory))
fi

# now check run the command
case $cmd in
	$CMD_REORIENT)	reorient
					exit 0
					;;
	*)				echo "error: $cmd is not a known command"
					exit 1
					;;
esac

