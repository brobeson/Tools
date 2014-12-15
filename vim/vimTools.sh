#!/bin/bash

# check the correct # of parameters
if [[ $# < 1 ]]
then
	echo "you need to tell me what to do!"
	exit 1
fi
action=$1

# use the home directory to determine if this is a windows or linux system.
# windows uses C:\Users\<username>\ which translates to /c/Users/<username> on git bash.
# linus uses /home/<username>.
# note that git bash apparently does not support the =~ operator, thus the == used here.
homeDir=~
if [[ $homeDir == /c/Users/* ]]
then
	# ms windows
	vimDir=vimfiles
	vimrc=_vimrc
else
	# linux
	vimDir=.vim
	vimrc=.vimrc
fi

# determine the copy direction based on the action:
# export: repository -> user's vim
# import: user's vim -> repository

# export from the repository to a user's vim home
if [[ $action == export ]]
then
	if [[ -e $homeDir/$vimDir ]]
	then
		if [[ ! -d $homeDir/$vimDir ]]
		then
			echo "$homeDir/$vimDir already exists, but is not a directory"
			exit 1
		fi
	else
		mkdir $homeDir/$vimDir
	fi
	cp -f vimrc $homeDir/$vimrc
	cp -rf vim/* $homeDir/$vimDir/

# import from a user's vim home to the repository
elif [[ $action == import ]]
then
	if [[ -e $homeDir/$vimrc ]]
	then
		cp -f $homeDir/$vimrc ./vimrc
	else
		echo "cannot import $homeDir/$vimrc because it does not exist"
	fi

	if [[ -e $homeDir/$vimDir ]]
	then
		cp -rf $homeDir/$vimDir/* ./vim/
	else
		echo "cannot import $homeDir/$vimDir because it does not exist"
	fi

# report an unknown action request
else
	echo "unknown action"
	exit 1
fi

