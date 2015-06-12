The files in `vim/` contain enhancements for using Vim. Most of them are centered around editing software code. The contents of `vim/` mirror what Vim expects when it looks for plugins. So you can copy .vim files from here to the corresponding location on your system.

`vimtools.sh` is a bash script I use to maintain this repository; it's not one you'll want to copy.

---

## Installing the Scripts
### Automated
From http://www.vim.org, you can download the latest release of [cpp_doxygen](http://www.vim.org/scripts/script.php?script_id=5194) and [cpp_cppcheck](http://www.vim.org/scripts/script.php?script_id=5192). Installation instructions can be found at the respective links.

### Manual
For other scripts, locate your home Vim configuration. On Linux, this is typically `~/.vim/`. On Windows 7, it's `C:\Users\you\vimfiles\`, where "you" is your username. Sorry, I'm not sure of the location in OSX, or if it's different on Windows 8. You can try `:echo &rtp` in Vim, and scan the output for your Vim home.

If you want the whole thing, copy everything in `vim/` to your home Vim configuration folder. Then copy `vimrc` to `~/.vimrc` (for Linux) or `C:\Users\you\_vimrc` (for Windows 7).

If you only want certain components, copy the desired files to the corresponding location in your home Vim configuration. For example, if you only want the STL syntax items, copy `vim/syntax/stl.vim` to `~/.vim/syntax/` or `C:\Users\you\vimfiles\syntax\`.

---

## Documentation
The `vim/vim/doc/` directory contains the documentation for the scripts, suitable for viewing within Vim. To use them, first copy the files corresponding to the scripts you want. Then start Vim and use the following command:
```
:helptags ~/.vim/doc/
```
After that, when working in Vim, you can look up help by keyword or script name:
```
:help cpp_tools
:help stl-syntax
```

---
## The Scripts
### Colors
I have a color file for syntax highlighting in Vim. vs2013dark.vim emulates most of the Dark color theme from MS Visual Studio 2013. I say "most of" because some elements from VS cannot be carried over to Vim, and some I've deliberately changed (such as the line numbers).

Copy `vim/colors/vs2013dark.vim` to `~/.vim/colors/`. Then, in your vimrc file, add the line `colorscheme vs2013dark`.

I don't recommend that you use mine.vim. It's basically here for archive purposes right now.

### General Plugins
The `vim/vim/plugin/` folder has tools for general code editing, capabilities common to most languages. The codeTools plugin provides:
- New mappings to manipulate text:
  - `\x` to move to the end of the line and erase the last character,
  - `\i` to enter insert mode before the last character of the current line,
  - `\r` to move to the end of the line, erase the last character, then enter insert mode after the new last character.
- Mappings to quickly set the fold level to 1-5: `z1`, `z2`, etc.
- Functions to comment and uncomment a range of lines. These functions are called by commands in the file type plugins described below.

### Filetype Plugins
The `vim/vim/ftplugin/` folder has tools for editing C++, LaTeX, Vim, and makefile code. In addition, the `vim/vim/plugin` directory has some functionality that is for editing code, but is common to all file types. Examples are the comment and uncomment functions, which are called from the file type plugins. The table below summarizes the functionality of each script. Read the corresponding Vim documentation for details.

#### C++
##### cpp_tools
The cpp_tools plugin provides some generic functionality for editing C++ source code:
- Custom code folding generates folds which appear as
```c++
// a compound statement
{    20 lines }

// #if 0 block
[ commented code ]

// anything else
NO FOLD TEXT DEFINED
```
- A mapping to comment and uncomment multiple lines of code.
- A mapping to insert a new class.
- Mappings to extract lines, and later paste them as a function.

##### cpp_doxygen
This plugin provides commands for inserting Doxygen template comments. With the cursor on a namespace, class, function, etcetera; the command will determine an appropriate Doxygen comment template and insert it before the code statement. The plugin also provides a code folding function for Doxygen comments. The function returns fold text which can be used by a custom, general code folding function. See the [documentation](https://raw.githubusercontent.com/brobeson/Tools/master/vim/vim/doc/cpp_doxygen.txt) for full details.

##### cpp_cppcheck
This plugin provides a command to run [Cppcheck](http://cppcheck.sourceforge.net) on the current buffer. You need to install Cppcheck separately. See the [documentation](https://raw.githubusercontent.com/brobeson/Tools/master/vim/vim/doc/cpp_cppcheck.txt) for details.

#### Make
The make_tools plugin provides:
- Custom code fold text of the form `first line  [     n lines ]`.
- Mappings to comment and uncomment multiple lines.
- Insertion of automatic variables by typing a descriptive name:
```make
# the first line becomes the second line...
	g++ -o make_target make_first_prereq
    g++ -o $@ $<
```

#### LaTeX
The tex_tools plugin provides:
- Custom code fold text similar to that of Make.
- Mappings to comment and uncomment multiple lines.

#### Vim
The vim_tools plugin provides:
- Custom code fold text similar to that of Make.
- Mappings to comment and uncomment multiple lines.

Copy the files you want to `~/.vim/ftplugin/`. You might need to confirm that Vim is configured to load them:

1. Start Vim and run `:filetype?`
2. If that reports "plugin:off", add "filetype plugin on" to your vimrc.

### Syntax Highlighting
Syntax definitions for HTML and the C++ STL are in the `vim/vim/syntax/` directory. The `vim/vim/after/syntax/` directory has a syntax file to modify a bit of C++ syntax highlighting, and to load the STL syntax items. Some of the syntax definitions have configuration variables; check the corresponding documentation for details.

Note that the STL syntax is usable, but not yet complete.
