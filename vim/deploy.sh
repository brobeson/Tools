#!/bin/bash

# copy the vimrc
cp -f vimrc ~/.vimrc

# TODO	check that ~/.vim exists and create it if necessary
# copy the vim folder
cp -rf vim/* ~/.vim/
