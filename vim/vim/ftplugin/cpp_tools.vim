" Vim plug-in to add a bunch of functionality related to C++ development.
" Last Change:  2016 January 19
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" I don't check if this file is already loaded. I found that if I do, then the
" fold settings don't take effect after closing and opening a C++ file

" check if this plug-in (or one with the same name) has already been loaded
" do this AFTER setting up code folding. I found that if I close a C++ buffer,
" then reopen it, the fold settings are all screwed up
if exists('b:loaded_cpp_tools')
    finish
endif
let b:loaded_cpp_tools = 1

" :help ft-c-syntax
let c_space_errors = 1

" the comment/uncomment plug-in
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>CppComment')
        map <buffer> <unique> <Leader>c <Plug>CppComment
    endif
    noremap  <buffer> <unique> <script> <Plug>CppComment :call Comment('//')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>CppUncomment')
        map <buffer> <unique> <Leader>u <Plug>CppUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>CppUncomment :call Uncomment('//')<CR>
endif

