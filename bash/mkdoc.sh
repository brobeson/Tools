#!/bin/bash

# store the base script name for later output
cmd=${0##*/}

# clean up levels
cleanLevels=(none, sweep, nuke)

# set up defaults
auxDir=../obj/doc
docDir=../build/doc
verbosity=-quiet
testMode=false
clean=${cleanLevels[0]}

# print messages
Error() { echo "$cmd  error   $1"; }
Info()
{
	if [[ $verbosity != "-quiet" ]]
   	then
	   	echo "$cmd  info    $1"
	fi
}


# this function is called when an error is detected in the command line
# or the user requests it with the option --help
PrintHelp()
{
	echo "Name"
	echo "    $cmd - render documentation from a specified LaTeX file"
	echo
	echo "Synopsis"
	echo "     $cmd [-cChv] [-s <filename>]"
	echo
	echo "Description"
	echo
	echo "Options"
	echo "    -c  Clean the auxilliary and output directories."
	echo "    -C  Remove the auxilliary and output directories. Implies -c."
	echo "    -h  Print this help and exit."
	echo "    -s  The path to the LaTeX file to render. If -c, -C, or -h are"
	echo "        supplied, -s is not required. If -c or -C, and -s are supplied"
	echo "        the directories are cleaned, then the input file is rendered."
	echo "    -t  Don't do anything, just report what would be done. Implies -v."
	echo "    -v  Verbose output. Without this option, only errors are printed."
	echo
	echo "Author"
	echo "    Brendan Robeson    brendan.robeson@sdl.usu.edu"
	echo
}


# test for a directory's existence, and make it if needed
TestAndMakeDir()
{
	if [[ ! -e $1 ]]
	then
		if [[ $testMode == false ]]
		then
		Info "Making $1"
			mkdir -p $1
		fi
	elif [[ ! -d $1 ]]
	then
		Error "$1 exists, but is not a directory."
		exit 1
	fi
}


# parse the options
while getopts "cChs:tv" option
do
	case "$option" in
		c)	clean=${cleanLevels[1]};;
		C)  clean=${cleanLevels[2]};;
		h)	PrintHelp
			exit 0;;
		s)	sourceFile=$OPTARG;;
		t)  testMode=true
			verbosity="";;
		v)  verbosity="";;
	esac
done

# clean up, if necessary
if [[ $clean == ${cleanLevels[1]} ]]
then
	Info "Cleaning $auxDir and $docDir..."
	if [[ $testMode == false ]]
	then
		rm -rf $auxDir/*
		rm -rf $docDir/*
	fi
elif [[ $clean == ${cleanLevels[2]} ]]
then
	Info "Nuking $auxDir and $docDir..."
	if [[ $testMode == false ]]
	then
		rm -rf $auxDir
		rm -rf $docDir
	fi
fi

# if the user did not specify an input file, print an error
if [[ -z ${sourceFile+set} ]]
then
	if [[ $clean == ${cleanLevels[0]} ]]
	then
		Error "You must specify an input file with -s. Use $cmd -h for details."
		exit 1
	fi

	# the user did some cleaning, but didn't supply an input file.
	# this is fine, it just means we have nothing to render, so we
	# can just exit.
	exit 0
fi

# make the aux and output directories if necessary
TestAndMakeDir $auxDir
TestAndMakeDir $docDir

# convert any Dia diagrams
#Info "converting Dia diagrams"
#for inputFilepath in ./images/*.dia
#do
#	outputFilepath=${inputFilepath##*/}			# strip the leading ./
#	outputFilepath=${outputFilepath%dia}eps		# change the extension from dia to eps
#	dia --nosplash -e "$auxDir/$outputFilepath" -t eps $inputFilepath
#done

# build the command once so we can run it twice
renderCmd="pdflatex -aux-directory=$auxDir -c-style-errors -disable-installer -output-directory=$docDir $verbosity $sourceFile"

Info "rendering pass 1..."
if $renderCmd
then
	Info "rendering pass 2..."
	if $renderCmd
	then
		echo "The render is complete."
	fi
fi

