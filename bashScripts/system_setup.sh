#!/bin/bash

# append to my bashrc {{{
# add a comment to the bashrc
printf "\n# here be my additions...\n" >> ~/.bashrc

# configure my bash prompt
# this is difficult to read. there is a lot of character escaping to prevent
# bash from expanding things. here is what the prompt string should be when
# written, as well as what each piece does:
# [date & time in green font] [current working directory]  (git branch)
# $
#                                         /       date & time in green font        \ /-current working directory
#PS1='${debian_chroot:+($debian_chroot)}\n[\[\e[32m\]\D{%Y %B %d %I:%M %p}\[\e[0m\]] [\w] $(__git_ps1) \n$ '
#                                       ^- new line                                       ^- current branch in git repo
printf "PS1='\${debian_chroot:+(\$debian_chroot)}\\\n[\\\[\\\e[32m\\\]\\\D{%%Y %%B %%d %%I:%%M %%p}\\\[\\\e[0m\\\]] [\\\w] \$(__git_ps1) \\\n$ '\n" >> ~/.bashrc

# enable color for gcc output
printf "export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'" >> ~/.bashrc
# }}}

# install packages {{{
apt-get install -y cifs-utils
apt-get install -y cmake
apt-get install -y git
apt-get install -y kdiff3
apt-get install -y vim-gtk
apt-get install -y vlc
apt-get install -y yakuake
# }}}

# configure git {{{
# use gvim as the editor, diff tool, and merge tool. make the merge tool not
# prompt me, and don't back up the originals when merging
git config --global user.name "brobeson"
git config --global user.email "ogslanger@vt.edu"
git config --global core.editor "gvim -f"
git config --global diff.tool gvimdiff
git config --global merge.tool gvimdiff
git config --global mergetool.prompt false
git config --global mergetool.keepbackup false

# git graph: create a branch graph using dot
#git config --global alias.graph !f() { echo 'digraph git {'; git log --pretty='format: %h -> { %p }' | sed 's/[0-9a-f][0-9a-f]*/"&"/g'; echo '}'; }; f

# git stash-it-all: stash everything, including untracked files
git config --global --add "alias.stash-it-all" "stash save --include-untracked"
# }}}

# checkout my tools repository {{{
mkdir -p ~/repositories
git clone git@github.com:brobeson/Tools.git ~/repositories/tools
# }}}

# restore my vim configuration {{{
mkdir -p ~/.vim
cp ~/repositories/tools/vim/vimrc ~/.vimrc
cp -r ~/repositories/tools/vim/vim/* ~/.vim/
# }}}

