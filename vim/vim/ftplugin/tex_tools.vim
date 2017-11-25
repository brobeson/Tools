" Vim plug-in to add a bunch of functionality related to LaTeX development.
" Last Change:  2017 November 24
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_tex_tools')
    finish
endif
let b:loaded_tex_tools = 1

" set some variables and local options 
let tex_flavor = 'latex'    " :help ft-tex-plug-in
setlocal noautoindent
setlocal nocindent
setlocal nosmartindent
setlocal cursorline

" the comment/uncomment plug-in 
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>LatexComment')
        map <buffer> <unique> <Leader>c <Plug>LatexComment
    endif
    noremap  <buffer> <unique> <script> <Plug>LatexComment :call Comment('%')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>LatexUncomment')
        map <buffer> <unique> <Leader>u <Plug>LatexUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>LatexUncomment :call Uncomment('%')<CR>
endif

setlocal makeprg=./make_report.sh\ $*
