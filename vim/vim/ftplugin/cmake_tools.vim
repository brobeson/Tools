" Vim plug-in to add a bunch of functionality related to CMake development.
" Last Change:  2019 January 13
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_cmake_tools')
    finish
endif
let b:loaded_cmake_tools = 1

" code folding {{{
" the fold text function
if !exists('*CMakeFoldText')
    function CMakeFoldText()
        if &diff
            let fold_text = printf('[ %5d identical lines ]', v:foldend - v:foldstart + 1)
        else
            let fold_text = getline(v:foldstart)
        endif
        return fold_text
    endfunction
endif

setlocal foldenable                " turn on code folding
setlocal foldmethod=syntax         " use the marker method for folding
setlocal foldtext=CMakeFoldText()  " use my function to build the fold text
" }}}

" the comment/uncomment plug-in {{{
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>CmakeComment')
        map <buffer> <unique> <Leader>c <Plug>CmakeComment
    endif
    noremap  <buffer> <unique> <script> <Plug>CmakeComment :call Comment('#')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>CmakeUncomment')
        map <buffer> <unique> <Leader>u <Plug>CmakeUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>CmakeUncomment :call Uncomment('#')<CR>
endif
"}}}

