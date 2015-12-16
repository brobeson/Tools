" Vim plug-in to add a bunch of functionality related to bash development.
" Last Change:	2015 December 16
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_sh_tools')
	finish
endif
let b:loaded_sh_tools = 1

" set some variables and local options {{{
let is_bash = 1                     " :help ft-bash-syntax
setlocal foldenable                 " enable code folding
setlocal foldmethod=marker          " find folds based on comment markers
setlocal foldtext=MarkerFoldText()  " use my default marker based fold text
"}}}

" the comment/uncomment plug-in {{{
if !exists('*Comment') || !exists('*Uncomment')
	echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>ShComment')
        map <buffer> <unique> <Leader>c <Plug>ShComment
    endif
    noremap  <buffer> <unique> <script> <Plug>ShComment :call Comment('#')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>ShUncomment')
        map <buffer> <unique> <Leader>u <Plug>ShUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>ShUncomment :call Uncomment('#')<CR>
endif
"}}}

