## What Do We Have Here?
The files in `vim/` contain enhancements for using Vim. Most of them are centered around editing software code.

### Colors
I have a color file for syntax highlighting in Vim. vs2013dark.vim emulates most of the Dark color theme from MS Visual Studio 2013. I say "most of" because some elements from VS cannot be carried over to Vim, and some I've deliberately changed (such as the line numbers).

### Documentation
The `vim/vim/doc/` folder contains the documentation for the Vim plugins, suitable for viewing within Vim.

### Filetype Plugins
The `vim/vim/ftplugin/` folder has tools for editing C++, LaTeX, and Vim code. In addition, the `vim/vim/plugin` directory has some functionality that is for editing code, but is common to all file types. Examples are the comment and uncomment functions, which are called from the file type plugins.

### Syntax
Syntax definitions for HTML and the C++ STL are in the `vim/vim/syntax/` directory. The `vim/vim/after/syntax/` directory has a syntax file to modify a bit of C++ syntax highlighting, and to load the STL syntax items.

## Gimme, Gimme, Gimme!
Locate your home Vim configuration. On Linux, this is typically `~/.vim/`. On Windows 7, it's `C:\Users\you\vimfiles\`, where "you" is your username. Sorry, I'm not sure of the location in OSX, or if it's different on Windows 8. You can try `:echo &rtp` in Vim, and scan the output for your Vim home.

### Installing the Scripts
If you want the whole thing, copy everything in `vim/` to your home Vim configuration folder. Then copy `vimrc` to `~/.vimrc` (for Linux) or `C:\Users\you\_vimrc` (for Windows 7).

If you only want certain components, copy the desired files to the corresponding location in your home Vim configuration. For example, if you only want the STL syntax items, copy `vim/syntax/stl.vim` to `~/.vim/syntax/` or `C:\Users\you\vimfiles\syntax\`.

### Installing the Color
Copy `vim/colors/vs2013dark.vim` to `~/.vim/colors/`. Then, in your vimrc file, add the line `colorscheme vs2013dark`.

### Installing the Documentation
Strictly speaking, you don't **need** the documentation, but it's recommended. Copy the .txt files corresponding to the Vim scripts you installed to your Vim home's `doc/' directory. Then start Vim and use the command `:helptags ~/.vim/doc/` (or with `c:\users\you\vimfiles\doc` if you use Windows). Now you can use `help $plugin_name` to get help for that plugin. For example, `:help cpp_tools.txt`.

## The Details
# codeTools
This is a general plugin for code editing; it contains some functionality common across the languages that I use.
 1. 
# File Type Plugins
I have filetype plugins for LaTeX, Vim, and C++. All three:
 1. Define a function to generate fold text, then set up some folding options.
 1. Define mappings to comment or uncomment a block of code.

In addition, the C++ plugin:
 1. Defines a function to generate the stub of a Doxygen comment.
 1. Define commands to manipulate text at the end of the current line.

## File Type Plugin Commands
All the commands use the Leader character. If you're not already familiar with it, the Vim variable `leader` holds a character used to initiate some custom commands. The default is `\`, but it can be changed with the line `:set leader=c` where `c` is the character you want to use. Using my plugins as an example, if, in normal mode, I type `\c`, the current line will be commented. If I first typed `:set leader=-`, then I'd have to type `-c` to comment the current line.

The table below summarizes the functionality. Command is the text to type while in normal mode. File Types lists the types of files for which the command is defined. Range specified whether a range can be given to the command. For example, one could type `15\c` to comment the current line and next 14 lines. Action gives a brief description of what the command does.

| Command | File Types | Range | Action |
|:--------|:----------:|:-----:|:-------|
| \c      | LaTeX, Vim, C++ |  yes  | Comment the specified range of lines. |
| \d      | C++             |  no   | Insert a Doxygen comment before the current line. |
| \i      | C++             |  no   | Enter insert mode before the last character on the current line. |
| \r      | C++             |  no   | Delete the last character on the current line, then enter insert mode, appending text to the line. |
| \u      | LaTeX, Vim, C++ |  yes  | Uncomment the specified range of lines. |
| \x      | C++             |  no   | Delete the last character on the current line. |

## File Type Plugin Details

### Comment & Uncomment Lines

Typing `[range]\c` will comment the range of lines, and typing `[range]\u` will comment a range of lines. The range is optional and takes the form of any range the Vim accepts. The comments are line, by line; that is, for C++, the block comment tokens `/* */` are not used. In addition, the comment markers are inserted at the left-most, first non-white space character in the range of lines. Take this C++ example:

```c++
class Foo                    // line 1
{                            // line 2
    public:                  // line 3
        Foo();               // line 4
        Foo(const int a,     // line 5
            const int b,     // line 6
            const int c);    // line 7
};                           // line 8
```
Assume you want to comment the non-default constructor. Position the cursor anywhere on line 5, and type `3\c`.  The result will be:
```c++
class Foo                    // line 1
{                            // line 2
    public:                  // line 3
        Foo();               // line 4
        //Foo(const int a,   // line 5
        //    const int b,   // line 6
        //    const int c);  // line 7
};                           // line 8
```

### Inserting Doxygen Comments

Typing `\d` will insert a Doxygen comment block before the current line. If the code contains the "delete" keyword, the code is assumed to be a deleted class method. The method is surrounded by `/** @cond */` and `/** @endcond */` comments, so Doxygen will not document it. Every other block will have `@brief` and `@details` tags. The command then uses the following rules to determine which other tags to add to the block:
 1. If the word "template" appears in the code, the `@tparam` tag is added for each template parameter.
 1. If parentheses are in the code, it is assumed to be a function and `@param` tags are added, according to these rules:
  1. If "const" appears before the type, `@param[in]` is used.
  1. If the parameter is reference, or a constant pointer, `@param[in,out]` is used.
  1. If the preceding rules are false, then `@param[in]` is used.
 1. If the code is a function, the return type will also be generated. The tags used depend on the return type:
  1. If the return type is "bool", then two tags are generated: `@retval true` and `@retval false`.
  1. If the return type is not "bool", then a single `@return` tag is added to the block.
 1. Finally, for functions, an `@exception` tag is generated.

This example shows what the `\d` command will generate:
```c++
/**
 * @brief
 * @details
 * @tparam    Type
 */
template <typename Type>
class Vector
{
public:
    /**
     * @brief
     * @details
     */
    Type x, y;

    /**
     * @brief
     * @details
     * @param[in]   xIn
     * @param[in]   yIn
     * @exception
     */
    Vector(const Type& xIn, const Type& yIn);
};
```

### Manipulating the End of a Line

In C++, I often find myself having to manipulate text at the end of a line. I might need to add more text before a ")" or ";", delete the last character on the line, or delete the last character and immediately begin editing.  I've mapped a few commands for these purposes.

`\i` will move the end of the line and enter insert mode before the last character. For example:
```c++
std::ifstream file;            // line 1
file.open("someFilename.txt";  // line 2
```
With the cursor anywhere on line 2, you can type `\i`. That will put you in insert mode before the semicolon and you can fix my typo.

`\x` will let you erase the last character. In this example, you need to remove an obsolete test, `someTest1`:
```c++
if ((someTest1 == 0) && (someTest2 != 0))
```
You put the cursor at the second open parenthesis and type `df(`, which will delete the text "(someTest1 == 0) && (". That leaves you with an extra ")" at the end of the line. You can now get rid of it by just typing `\x`.

Finally, `\r` will erase the last character, then enter insert mode after the new last character. Using the previous example, let's say you need to expand the statement following the conditional into a block statement:
```c++
if ((someTest1 == 0) && (someTest2 != 0))
    errorCode = 1;
```
You put the cursor at the second open parenthesis and type `df(`, which will delete the text "(someTest1 == 0) && (". As before, that leaves you with an extra ")" at the end of the line. You can now get rid of it and start appending code (such as a newline and an opening brace) by just typing `\r`.

### Code Folding

I'm not a fan of the default code folding in Vim. I find it too intrusive, where the purpose of folding it to remove extraneous information from the display. So I wrote my own functions for generated fold text. Before I get into those gory details, let me describe some folding options I set:
 * Ensure the code folding is on.
 * Remove the fold column (I never used it).
 * Set the fold method (syntax for C++, marker for Vim and LaTeX).
 * Set the fold text function.
 * Set the fold fill character to a space. This is a big one for me; lines all the way across the screen are very distracting.

One note common to all the code folding functions: The fold text aligns with the original first line.

#### Vim Fold Text

The fold text for Vim is very straightforward. The result is:
```
[    nn lines ]    the comment containing the fold marker
```
Taking my cpp.vim file as an example, the comment line
```
" map some normal mode keystrokes to common C++ editing operations {{{
```
generates this fold text:
```
[    14 lines ]    map some normal mode keystrokes to common C++ editing operations
```

#### LateX Fold Text

The fold text for LaTeX is also pretty simple. When the fold marker follows an environment, that environment is used:
```
\begin{document} %{{{
```
generates the fold text
```
\begin{document}...
```
Ditto for `\section`, `\subsection`, etc. If the fold marker is on a comment line, then the comment text is used instead of the LaTeX environment:
```
% Let's get this party started! {{{
\begin{document}
```
when folded, results in:
```
Lets get this party started!
```

#### C++ Fold Text

This one is bit more complicated, because I handle more cases.

##### #if 0 Blocks

I loathe this practice, but come across it from other developers at work. For code blocks wrapped in `#if 0` or `#ifdef 0`, the folded text is merely `[ commented code ]  the first line of actual code`.

##### Doxygen Comment Blocks

If the fold is identified as a Doxygen comment block, the function looks for the `@brief` tag, and uses its text. If no such tag is found, then the text "no brief text is used". **This requires that the `@brief` tag be followed by some other tag!** This example comment block:
```c++
/**
 * @brief      Compute the dot product of two vectors.
 * @param[in]  v,w  The two vector operands to the dot product operation.
 * @return     The result of \f$v \dot w\f$.
 * @exception  None.
 */
```
will fold up to:
```c++
/** Compute the dot product of two vectors. */
```

##### C++ Code Blocks

Finally, for a folded block of code, the text is `{ nnnnn lines }`, where "nnnnn" is the number of lines. The example:
```c++
float dot(const Vector& v, const Vector& w)
{
   return (v.x * w.x) + (v.y * w.y);
}
```
will fold up to:
```c++
float dot(const Vector& v, const Vector& w)
{     3 lines }
```
