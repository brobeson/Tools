The files in `vim/` contain enhancements for using Vim. Most of them are centered around editing software code. The contents of `vim/` mirror what Vim expects when it looks for plugins. So you can copy .vim files from here to the corresponding location on your system.

`vimtools.sh` is a bash script I use to maintain this repository; it's not one you'll want to copy.

---

## Installing the Scripts
Locate your home Vim configuration. On Linux, this is typically `~/.vim/`. On Windows 7, it's `C:\Users\you\vimfiles\`, where "you" is your username. Sorry, I'm not sure of the location in OSX, or if it's different on Windows 8. You can try `:echo &rtp` in Vim, and scan the output for your Vim home.

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

### Filetype Plugins
The `vim/vim/ftplugin/` folder has tools for editing C++, LaTeX, and Vim code. In addition, the `vim/vim/plugin` directory has some functionality that is for editing code, but is common to all file types. Examples are the comment and uncomment functions, which are called from the file type plugins. The table below summarizes the functionality of each script. Read the corresponding Vim documentation for details.

| Functionality | C++ | LaTeX | Vim |
|---------------|:---:|:-----:|:---:|
| comment/uncomment | x | x | x |
| insert before last character | x | x | x |
| remove last character, then append | x | x | x |
| remove last character | x | x | x |
| set the fold level | x | x | x |
| code fold text | x | x | x |
| insert Doxygen | x | | |
| insert new class | x | | |
| extract to new function | x | | |

Copy the files you want to `~/.vim/ftplugin/`. You might need to confirm that Vim is configured to load them:

1. Start Vim and run `:filetype?`
2. If that reports "plugin:off", add "filetype plugin on" to your vimrc.

### Syntax Highlighting
Syntax definitions for HTML and the C++ STL are in the `vim/vim/syntax/` directory. The `vim/vim/after/syntax/` directory has a syntax file to modify a bit of C++ syntax highlighting, and to load the STL syntax items. Some of the syntax definitions have configuration variables; check the corresponding documentation for details.

Note that the STL syntax is usable, but not yet complete.
