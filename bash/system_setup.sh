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
#PS1='${debian_chroot:+($debian_chroot)}\n[\[\e[32m\]\D{%Y %B %d %I:%M %p} on \h\[\e[0m\]] [\w] $(__git_ps1) \n$ '
#                                       ^- new line                           ^-hostname        ^- current branch in git repo
printf "PS1='\${debian_chroot:+(\$debian_chroot)}\\\n[\\\[\\\e[32m\\\]\\\D{%%Y %%B %%d %%I:%%M %%p} on \\\h\\\[\\\e[0m\\\]] [\\\w] \$(__git_ps1) \\\n$ '\n" >> ~/.bashrc
# PS1='${debian_chroot:+($debian_chroot)}\n\[\e[31m\]\h \[\e[32m\]\D{%Y %B %d %I:%M %p} \[\e[36m\]\w \[\e[0m\]$(__git_ps1)\n'

# enable color for gcc output
printf "export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'" >> ~/.bashrc
printf "shopt -s globstar" >> ~/.bashrc
# }}}

# install packages {{{
sudo apt-get install --yes \
  cifs-utils \
  clang-7 \
  clang-8 \
  clang-9 \
  clang-10 \
  cmake \
  cmake-curses-gui \
  cppcheck \
  darktable \
  doxygen \
  exuberant-ctags \
  g++-7 \
  g++-8 \
  g++-10 \
  git \
  graphviz \
  inkscape \
  libasan5 \
  libasan6 \
  libubsan1 \
  plantuml \
  texlive-full \
  valgrind \
  vim-gtk \
  vlc \
  yakuake \
  python3-pip
sudo pip3 install \
  black \
  coverage \
  gcovr \
  got10k \
  lizard \
  PyYAML \
  Sphinx
sudo snap install --classic code

#code --force --install-extension cschlosser.doxdocgen
#code --force --install-extension davidanson.vscode-markdownlint
#code --force --install-extension dbaeumer.vscode-eslint
#code --force --install-extension denniskempin.vscode-include-fixer
#code --force --install-extension eamodio.gitlens
#code --force --install-extension gruntfuggly.todo-tree
#code --force --install-extension ibm.output-colorizer
#code --force --install-extension james-yu.latex-workshop
#code --force --install-extension lextudio.restructuredtext
#code --force --install-extension marvhen.reflow-markdown
#code --force --install-extension ms-python.python
#code --force --install-extension ms-vscode.cmake-tools
#code --force --install-extension ms-vscode.cpptools
#code --force --install-extension notskm.clang-tidy
#code --force --install-extension pokowaka.pokowaka-iwyu
#code --force --install-extension streetsidesoftware.code-spell-checker
#code --force --install-extension twxs.cmake
#code --force --install-extension vscodevim.vim
#code --force --install-extension xaver.clang-format

code --force --install-extension brunnerh.insert-unicode
code --force --install-extension cadenas.vscode-glsllint
code --force --install-extension fizzybreezy.gnuplot
code --force --install-extension github.vscode-pull-request-github
code --force --install-extension jebbs.plantuml
code --force --install-extension mhutchie.git-graph
code --force --install-extension ms-python.vscode-pylance
code --force --install-extension njpwerner.autodocstring
code --force --install-extension slevesque.shader
code --force --install-extension tonka3000.qtvsctools

# }}}

# configure git {{{
# use gvim as the editor, diff tool, and merge tool. make the merge tool not
# prompt me, and don't back up the originals when merging
git config --global core.editor "gvim -f"
git config --global diff.tool gvimdiff
git config --global merge.tool gvimdiff
git config --global mergetool.keepbackup false
git config --global mergetool.prompt false
git config --global push.default simple
git config --global user.name "brobeson"
git config --global user.email "brobeson@users.noreply.github.com"

# git graph: create a branch graph using dot
#git config --global alias.graph !f() { echo 'digraph git {'; git log --pretty='format: %h -> { %p }' | sed 's/[0-9a-f][0-9a-f]*/"&"/g'; echo '}'; }; f

# git stash-it-all: stash everything, including untracked files
git config --global --add "alias.stash-it-all" "stash save --include-untracked"

# create a system wide git ignore file
# *.sw*   ignore vim swap files
echo '*.sw*' > ~/.gitignore
git config --global core.excludesfile "~/.gitignore"
# }}}

# checkout my tools repository {{{
#mkdir -p ~/repositories
#git clone git@github.com:brobeson/Tools.git ~/repositories/tools
# }}}

# restore my vim configuration {{{
#mkdir -p ~/.vim
#cp ~/repositories/tools/vim/vimrc ~/.vimrc
#cp -r ~/repositories/tools/vim/vim/* ~/.vim/
# }}}

