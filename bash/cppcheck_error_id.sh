#!/bin/bash

if [[ $# -ne 1 ]]
then
    >&2 echo "usage: cppcheck_error_id.sh FILENAME"
    exit 1
fi

cppcheck --xml-version=2 --enable=all $1
