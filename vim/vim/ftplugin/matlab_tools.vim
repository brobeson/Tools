" Vim plug-in to add a bunch of functionality related to LaTeX development.
" Last Change:  2016 November 20
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_matlab_tools')
    finish
endif
let b:loaded_matlab_tools = 1

" set some variables and local options 
setlocal fo-=t
setlocal nospell

" the comment/uncomment plug-in 
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>MatlabComment')
        map <buffer> <unique> <Leader>c <Plug>MatlabComment
    endif
    noremap  <buffer> <unique> <script> <Plug>MatlabComment :call Comment('%')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>MatlabUncomment')
        map <buffer> <unique> <Leader>u <Plug>MatlabUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>MatlabUncomment :call Uncomment('%')<CR>
endif

