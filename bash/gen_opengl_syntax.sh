#!/bin/bash

# default variable values {{{
clean=0
remove_sandbox=0
sandbox=$(pwd)
script_name=$(basename "$0")
syntax_file="${HOME}/.vim/syntax/opengl.vim"
# }}}

# this function will print the help when requested {{{
function print_help
{
    echo "NAME"
    echo "    ${script_name} - generate Vim syntax from OpenGL documentation"
    echo
    echo "SYNOPSIS"
    echo "    ${script_name} [OPTIONS] [VIM_SYNTAX_FILE]"
    echo
    echo "DESCRIPTION"
    echo "    This script will attempt to checkout the OpenGL documentation"
    echo "    repository from the Subversion repository. Then it will parse"
    echo "    the documentation for OpenGL functions, types, and constants."
    echo "    These tokens will be inserted into the Vim syntax file located at"
    echo "    VIM_SYNTAX_FILE. The default syntax file is"
    echo "    ${syntax_file}"
    echo
    echo "    Mandatory arguments to long options are mandatory for short"
    echo "    options too."
    echo
    echo "    -c, --clean"
    echo "        Clean up the Subversion sandbox before checking out the"
    echo "        documentation."
    echo
    echo "    -h, --help"
    echo "        Print this help, then exit"
    echo
    echo "    -s DIRECTORY, --sandbox=DIRECTORY"
    echo "        Specifies the directory to use as the Subversion sandbox for"
    echo "        checking out the OpenGL documentation. If omitted, the"
    echo "        current working directory is used."
    echo
    echo "AUTHOR"
    echo "    Brendan Robeson (https://github.com/brobeson/Tools)"
    echo
    echo "REPORTING BUGS"
    echo "    Create an issue at the author's Github repository."
    echo
}
# }}}

# parse the command line for options {{{
options=$(getopt --options chs: --longoptions clean,help,sandbox: --name ${script_name} -- "$@")
eval set -- "${options}"
while [[ $1 != "--" ]]
do
    case "$1" in
        -c|--clean)     clean=1
                        shift
                        ;;
        -h|--help)      print_help
                        exit 0
                        ;;
        -s|--sandbox)   # replace a ~ at the beginning of the sandbox path with the value of $HOME
                        sandbox="${2/#\~/$HOME}"
                        shift 2
                        ;;
        *)              echo "unknown option: $1"
                        exit ${exit_failure}
                        ;;
    esac
done
# shift off the --, then get the path to the syntax file
shift
syntax_file="${1:-${syntax_file}}"
# }}}

# check that subversion is installed {{{
echo -n "verifying Subversion installation..."
which svn &> /dev/null
if [[ $? != 0 ]]
then
    echo "Subversion could not be found. Install it, or add it's location to"
    echo "your path variable."
    exit 1
fi
echo " Subversion found"
# }}}

# prep the sandbox {{{
# if the sandbox exists, but is not a directory, report an error
# if the sandbox does not exist, create it. in this case, if the user requested
# cleanup, then mark the sandbox directory for removal
echo -n "preparing the sandbox..."
if [[ -e "${sandbox}" && ! -d "${sandbox}" ]]
then
    echo "The requested sandbox, \"${sandbox}\", already exists, but is not a"
    echo "directory. Please remove it, rename it, or choose a different sandbox"
    echo "location."
    exit 1
elif [[ ! -e "${sandbox}" ]]
then
    mkdir -p "${sandbox}"
    if [[ ${clean} == 1 ]]
    then
        remove_sandbox=1
    fi
fi
echo " sandbox ready"
if [[ ${clean} == 1 ]]
then
    echo "    sandbox marked for cleanup after generation"
    if [[ ${remove_sandbox} == 1 ]]
    then
        echo "    sandbox marked for removal after generation"
    else
        echo "    sandbox NOT marked for removal after generation"
    fi
else
    echo "    sandbox NOT marked for cleanup after generation"
    echo "    sandbox NOT marked for removal after generation"
fi
# }}}

# checkout the documentation from OpenGL {{{
echo -n "checking out the OpenGL documentation..."
repository="https://cvs.khronos.org/svn/repos/ogl/trunk/ecosystem/public/sdk/docs/man4/"
svn checkout --username anonymous --password anonymous ${repository} "${sandbox}"
#svn checkout --username anonymous --password anonymous --trust-server-cert --non-interactive ${repository} "${sandbox}"
if [[ $? != 0 ]]
then
    echo "failed to checkout the OpenGL documentation"
    echo "not running cleanup so you can inspect the sandbox"
    exit 1
fi
echo " got it"
# }}}

# find the OpenGL constants, types, and functions {{{
documentation="${sandbox}/*.xml"
grep_for="grep --only-matching --no-filename"
sort_and_make_unique="sort --unique"
functions_file="/tmp/functions.tmp"
constants_file="/tmp/constants.tmp"
types_file="/tmp/types.tmp"

# find all the OpenGL constants. they start with GL_
${grep_for} "GL_[A-Z0-9_]\+" ${documentation} | ${sort_and_make_unique} > ${constants_file}
sed --in-place 's/^/\\ /' ${constants_file}

# find all the OpenGL types they start with GL[a-z]
${grep_for} "GL[a-z]\+" ${documentation} | ${sort_and_make_unique} > ${types_file}
sed --in-place 's/^/\\ /' ${types_file}

# find all the OpenGL functions. they start with gl[A-Z]. we need to find the lines
# with the <function> xml tag. for some functions, similar functions are grouped in
# one xml document, which also contains the function root. for example:
#	glUniform is a function root, but not an actual function
#	glUniform2i is a function in glUniform.xml
${grep_for} "<funcdef>.*<function>gl[A-Z][a-zA-Z0-9]\+" ${documentation} | sed 's/<funcdef>.*<function>//' | ${sort_and_make_unique} > ${functions_file}
sed --in-place 's/^/\\ /' ${functions_file}
# }}}

# write the syntax file {{{
# write the file comment
echo -n "writing Vim syntax file..."
echo "\" Vim syntax file" > ${syntax_file}
echo "\" Language:     OpenGL C/C++" >> ${syntax_file}
echo "\" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)" >> ${syntax_file}
echo -n "\" Last Change:  " >> ${syntax_file}
date +"%Y %B %d" >> ${syntax_file}
echo "\"" >> ${syntax_file}
echo "\" This file is auto generated from the docbook sources at" >> ${syntax_file}
echo "\" https://cvs.khronos.org/svn/repos/ogl/trunk/ecosystem/public/sdk/docs/man4/" >> ${syntax_file}
echo "\"" >> ${syntax_file}
echo "\" If you find an error, or have a feature request, please create an issue at" >> ${syntax_file}
echo "\" https://github.com/brobeson/Tools/issues." >> ${syntax_file}
echo "" >> ${syntax_file}
echo "\" Quit if OpenGL syntax is already loaded." >> ${syntax_file}
echo "if exists('b:opengl_syntax_loaded')" >> ${syntax_file}
echo "    finish" >> ${syntax_file}
echo "endif" >> ${syntax_file}
echo >> ${syntax_file}

# write the OpenGL constants
echo "\" constants {{{" >> ${syntax_file}
echo "syntax keyword glConstant" >> ${syntax_file}
cat ${constants_file} >> ${syntax_file}
echo "\" }}}" >> ${syntax_file}
echo >> ${syntax_file}

# write the OpenGL functions
echo "\" functions {{{" >> ${syntax_file}
echo "syntax keyword glFunction" >> ${syntax_file}
cat ${functions_file} >> ${syntax_file}
echo "\" }}}" >> ${syntax_file}
echo >> ${syntax_file}

# write the OpenGL types
echo "\" types {{{" >> ${syntax_file}
echo "syntax keyword glType" >> ${syntax_file}
cat ${types_file} >> ${syntax_file}
echo "\" }}}" >> ${syntax_file}
echo >> ${syntax_file}

# link the OpenGL syntax groups to default groups
echo "highlight default link glConstant   constant" >> ${syntax_file}
echo "highlight default link glFunction   function" >> ${syntax_file}
echo "highlight default link glType       type" >> ${syntax_file}
echo >> ${syntax_file}
echo "let b:opengl_syntax_loaded = 1" >> ${syntax_file}

echo " written"
# }}}

# cleanup after ourselves {{{
echo -n "cleaning up the sandbox..."
if [[ ${clean} == 1 ]]
then
    rm -r "${sandbox}/*" 2> /dev/null
    if [[ ${remove_sandbox} == 1 ]]
    then
        rmdir "${sandbox}" 2> /dev/null
    fi
fi
echo " clean"
# }}}
