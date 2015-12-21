#!/bin/bash

# configure git {{{
# use gvim as the editor, diff tool, and merge tool. make the merge tool not
# prompt me, and don't back up the originals when merging
git config --global core.editor "gvim -f"
git config --global diff.tool gvimdiff
git config --global merge.tool gvimdiff
git config --global mergetool.prompt false
git config --global mergetool.keepbackup false

# git graph: create a branch graph using dot
#git config --global alias.graph !f() { echo 'digraph git {'; git log --pretty='format: %h -> { %p }' | sed 's/[0-9a-f][0-9a-f]*/"&"/g'; echo '}'; }; f

# git stash-it-all: stash everything, including untracked files
#git config --global alias.stash-it-all stash save --include-untracked
# }}}

# modify my bashrc {{{
# configure my bash prompt
# [date & time in green font] [current working directory]  (git branch)
# $
#                                        /       date & time in green font        \ /-current working directory
PS1='${debian_chroot:+($debian_chroot)}\n[\[\e[32m\]\D{%Y %B %d %I:%M %p}\[\e[0m\]] [\w] $(__git_ps1) \n$ '
#                                      ^- new line                                       ^- current branch in git repo

# enable color for gcc output
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# }}}
