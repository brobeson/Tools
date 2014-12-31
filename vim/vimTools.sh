#!/bin/bash

# print information about how to use the script
PrintHelp()
{
	echo "Import Vim scripts to the repository, or export them from the repository."
	echo "The scripts are imported from, or exported to, the user's vim directory."
	echo "On Linux, this is ~/.vim/ and ~/.vimrc. On Windows, this is"
	echo "C:\Users\<username>\vimfiles and C:\Users\<username>\_vimrc."
	echo
	echo "Usage: vimTools.sh export|import"
	echo
	echo "Action Descriptions"
	echo "    export    Export scripts from the repository to your Vim directory."
	echo "    import    Import scripts from your Vim directory to the repository."
	echo
}

# check the correct # of parameters
if [[ $# < 1 ]]
then
	PrintHelp
	exit 0
fi
action=$1

# use the home directory to determine if this is a windows or linux system.
# windows uses C:\Users\<username>\ which translates to /c/Users/<username> on git bash.
# linus uses /home/<username>.
# note that git bash apparently does not support the =~ operator, thus the == used here.
windowsPlatform=Windows
linuxPlatform=Linux
homeDir=~
if [[ $homeDir == /c/Users/* ]]
then
	# ms windows
	vimDir=vimfiles
	vimrc=_vimrc
	platform=$windowsPlatform
	#mergeTool='/c/Program\ Files\ \(x86\)/KDiff3/kdiff3.exe'
	#echo $mergeTool
else
	# linux
	vimDir=.vim
	vimrc=.vimrc
	platform=$linuxPlatform
fi

# determine the copy direction based on the action:
# export: repository -> user's vim
# import: user's vim -> repository

# export from the repository to a user's vim home
if [[ $action == export ]]
then
	if [[ $platform == $windowsPlatform ]]
	then
		/c/Program\ Files\ \(x86\)/KDiff3/kdiff3.exe ./vimrc $homeDir/$vimrc -o $homeDir/$vimrc
	else
		kdiff3 ./vimrc $homeDir/$vimrc -o $homeDir/$vimrc
	fi

	if [[ ! -e $homeDir/$vimDir ]]
	then
		mkdir $homeDir/$vimDir
	fi
	if [[ -d $homeDir/$vimDir ]]
	then
		if [[ $platform == $windowsPlatform ]]
		then
			/c/Program\ Files\ \(x86\)/KDiff3/kdiff3.exe ./vim/ $homeDir/$vimDir/ -o $homeDir/$vimDir/
		else
			kdiff3 ./vim/ $homeDir/$vimDir/ -o $homeDir/$vimDir/
		fi
	else
		echo "$homeDir/$vimDir already exists, but is not a directory"
	fi

# import from a user's vim home to the repository
elif [[ $action == import ]]
then
	if [[ -e $homeDir/$vimrc ]]
	then
		if [[ $platform == $windowsPlatform ]]
		then
			/c/Program\ Files\ \(x86\)/KDiff3/kdiff3.exe $homeDir/$vimrc ./vimrc -o ./vimrc
		else
			kdiff3 $homeDir/$vimrc ./vimrc -o ./vimrc
		fi
	else
		echo "cannot import $homeDir/$vimrc because it does not exist"
	fi

	if [[ -e $homeDir/$vimDir ]]
	then
		if [[ $platform == $windowsPlatform ]]
		then
			/c/Program\ Files\ \(x86\)/KDiff3/kdiff3.exe $homeDir/$vimDir/ ./vim/ -o ./vim/
		else
			kdiff3 $homeDir/$vimDir/ ./vim/ -o ./vim/
		fi
	else
		echo "cannot import $homeDir/$vimDir because it does not exist"
	fi

# report an unknown action request
else
	PrintHelp
	exit 1
fi

