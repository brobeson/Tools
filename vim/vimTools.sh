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
if [[ $action == export ]]
then
	cp -f vimrc $homeDir/$vimrc
	cp -rf vim/* $homeDir/$vimDir/
elif [[ $action == import ]]
then
	cp -f $homeDir/$vimrc ./
	cp -rf $homeDir/$vimDir/* ./vim/
else
	echo "unknown action"
	exit 1
fi

# copy the vimrc
#cp -f vimrc ~/.vimrc

# TODO	check that ~/.vim exists and create it if necessary
# copy the vim folder
#cp -rf vim/* ~/.vim/
