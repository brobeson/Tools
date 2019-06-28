" Vim plug-in to add a bunch of functionality related to C++ development.
" Last Change:  2019 June 28
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

" :help cinoptions
set cinoptions+=g0

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


"============================================================================
" define the functions to comment and uncomment a range of lines {{{
if !exists('*WordComment')
    function WordComment()
        " first, insert the leading comment token. move the cursor one character
        " right. this overcomes the case that the cursor is on the first
        " character of the word. in that case, the 'b' command would move to the
        " previous word, instead of the start of this word.
        execute 'normal lbi/*'

        " jump to the end of the word, and append the closing comment token
        execute 'normal ea*/'
    endfunction
endif

" define the function to uncomment a range of lines
if !exists('*WordUncomment')
    function WordUncomment() range
        execute 'normal F/xx'
        execute 'normal f*xx'
    endfunction
endif
"}}}

if !hasmapto('<Plug>CppWordComment')
    map <buffer> <unique> <Leader>wc <Plug>WordComment
endif
noremap <buffer> <unique> <script> <Plug>WordComment :call WordComment()<CR>

if !hasmapto('<Plug>CppWordUncomment')
    map <buffer> <unique> <Leader>wu <Plug>WordUncomment
endif
noremap <buffer> <unique> <script> <Plug>WordUncomment :call WordUncomment()<CR>

" A function and map to run Clang-Format on the current file.
function! CppRunFormatter()
  if &diff == 0
    execute '!clang-format -i -style=file %:p'
  endif
endfunction
if !hasmapto('<Plug>Formatter')
  map <buffer> <unique> <Leader>f <Plug>Format
endif
noremap <buffer> <unique> <script> <Plug>Format :call CppRunFormatter()<CR>

"      "call system('lizard --CCN 10 --arguments 4 --warnings_only --modified ' . shellescape(expand('%:p')))
"      "execute '!lizard --CCN 10 --arguments 4 --warnings_only --modified %:p'
"      cexpr '!lizard --CCN 10 --arguments 4 --warnings_only --modified %:p'
"      "execute '!cppcheck --enable=warning --enable=style --enable=information --error-exitcode=1 --inline-suppr %:p'
"    endif
"  endfunction
"endif

" On write, run formatting, linters, etc. 'edit!' is required after the
" formatter; apparently, autoread doesn't work in this specific case.
autocmd BufWritePost,FileWritePost <buffer> call CppRunFormatter() | edit!
"autocmd BufWritePost,FileWritePost <buffer> execute '!cppcheck --enable=warning --enable=style --inline-suppr %:p'
"autocmd BufWritePost,FileWritePost <buffer> execute '!clang-tidy -fix -fix-errors -format-style=file %:p'
