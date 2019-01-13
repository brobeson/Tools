" Vim plug-in to set the fold text of Python code
" Last Change:  2018 October 1
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" I don't check if this file is already loaded. I found that if I do, then the
" fold settings don't take effect after closing and opening a C++ file

" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. I'm not sure why, but I can't make
" this a script local function. if I do, then use
" 'set foldtext=<SID>PythonFoldText', then the folding doesn't display correctly.
if !exists('*PythonFoldText')
    function PythonFoldText()
        " start by folding a doxygen comment
        let fold_text = ''

        " get the first line. we need it to determine what type of fold text
        " to create. also initialize the fold text in a way to indicate a
        " folding case I haven't handled.
        let first_line = getline(v:foldstart)
        let space_count = match(first_line, '\S')
        let fold_text = repeat(' ', space_count) . '{'
        let fold_text .= printf(' %3d lines }', v:foldend - v:foldstart + 1)

        return fold_text
    endfunction
endif

setlocal foldenable
setlocal foldmethod=indent
setlocal foldtext=PythonFoldText()
setlocal foldignore=
