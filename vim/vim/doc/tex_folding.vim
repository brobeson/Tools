*tex_folding.txt*     For Vim version 7.4.    Last Change: 2015 Mar 11

Plugin with some helpful commands for editing LaTeX code.

Code Folding Text                   *tex_code_folding*
The code folding text varies depending on what is folded.

If the first line is a comment, the comment text is used, appended with an
ellipsis. For example, if this line begins a fold in a LaTeX document:
% description of this section {{{~
When folded, the fold text is simpley:
description of this section ...~

If the first line is not a comment, the plugin looks for the first LaTeX
command (\begin, \section, etc) and uses that:
\begin{document} %{{{~
folds up to
\begin{document}...~
In this case, if a command is not found, the fold text is
no LaTeX command found~

All the fold text options indent the fold text to match the original
indentation of the first line of the fold.

vim:tw=78:ts=8:ft=help:norl:

