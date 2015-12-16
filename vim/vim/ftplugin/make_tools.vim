" Vim plug-in to add a bunch of functionality related to make file development
" Last Change:  2015 December 16
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_make_tools')
    finish
endif
let b:loaded_make_tools = 1

" local options {{{
" this column helps me guide output via echo commands. it gives me 11 columns
" for tab, command and opening ". Then 80 columns for the echo text.
setlocal colorcolumn=92
setlocal foldenable                 " enable code folding
setlocal foldmethod=marker          " find folds based on comment markers
setlocal foldtext=MarkerFoldText()  " use my default marker based fold text
"}}}

" the comment/uncomment plug-in {{{
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>MakeComment')
        map <buffer> <unique> <Leader>c <Plug>MakeComment
    endif
    noremap  <buffer> <unique> <script> <Plug>MakeComment :call Comment('#')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>MakeUncomment')
        map <buffer> <unique> <Leader>u <Plug>MakeUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>MakeUncomment :call Uncomment('#')<CR>
endif
"}}}

" auto replacement of make automatic variables {{{
iabbrev make_target $@
iabbrev make_archive $%
iabbrev make_first_prereq $<
iabbrev make_newer_prereqs $?
iabbrev make_prereqs $^
iabbrev make_all_prereqs $+
iabbrev make_target_stem $*
" }}}

