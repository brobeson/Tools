" Vim plug-in to add a bunch of functionality related to C++ development.
" Last Change:  2019 July 24
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

if exists('b:loaded_cpp_tools')
  finish
endif
let b:loaded_cpp_tools = 1

" :help ft-c-syntax
let c_space_errors = 1

" :help cinoptions
setlocal cinoptions+=g0
setlocal colorcolumn=81

" Set up key mappings to comment and uncomment lines of code.
if !exists('*Comment') || !exists('*Uncomment')
  echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
  if !hasmapto('<Plug>CppComment')
    map <buffer> <unique> <Leader>c <Plug>CppComment
  endif
  noremap  <buffer> <unique> <script> <Plug>CppComment :call Comment('//')<CR>
  if !hasmapto('<Plug>CppUncomment')
    map <buffer> <unique> <Leader>u <Plug>CppUncomment
  endif
  noremap  <buffer> <unique> <script> <Plug>CppUncomment :call Uncomment('//')<CR>
endif


" Set up functions and key mappings to comment and uncomment single words. This
" is useful to comment out a function argument.
function! WordComment()
  " First, insert the leading comment token. Move the cursor one character
  " right. this overcomes the case that the cursor is on the first character
  " of the word. In that case, the 'b' command would move to the previous
  " word, instead of the start of this word.
  execute 'normal lbi/*'

  " Jump to the end of the word, and append the closing comment token.
  execute 'normal ea*/'
endfunction
function! WordUncomment() range
  execute 'normal F/xx'
  execute 'normal f*xx'
endfunction
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

" A function and map to run Cppcheck on the current file.
function! CppRunCppcheck()
  if &diff == 0
    let original_makeprg = &makeprg
    setlocal makeprg=cppcheck\ --template=gcc\ --enable=warning\ --enable=style\ --error-exitcode=1\ --suppress=syntaxError\ --inline-suppr\ --language=c++\ %:p
    make
    let &makeprg = original_makeprg
  endif
endfunction
if !hasmapto('<Plug>Cppcheck')
  map <buffer> <unique> <Leader>C <Plug>Cppcheck
endif
noremap <buffer> <unique> <script> <Plug>Cppcheck :call CppRunCppcheck()<CR>

" A function and map to run Lizard on the current file.
function! CppRunLizard()
  if &diff == 0
    let original_makeprg = &makeprg
    setlocal makeprg=lizard\ --CCN\ 10\ --arguments\ 4\ --warnings_only\ --modified\ %:p
    let qf_list = getqflist()
    make
    call setqflist(qf_list, 'a')
    let &makeprg = original_makeprg
  endif
endfunction
if !hasmapto('<Plug>Cppcheck')
  map <buffer> <unique> <Leader>l <Plug>Lizard
endif
noremap <buffer> <unique> <script> <Plug>Lizard :call CppRunLizard()<CR>

" On write, run formatting, linters, etc. 'edit!' is required after the
" formatter; apparently, autoread doesn't work in this specific case.
augroup CppLintChecks
  autocmd BufWritePost,FileWritePost <buffer> call CppRunFormatter() 
    \ | call CppRunCppcheck()
    \ | call CppRunLizard()
  autocmd QuickFixCmdPost [^l]* nested cwindow
  "autocmd QuickFixCmdPost l* nested lwindow
augroup end
