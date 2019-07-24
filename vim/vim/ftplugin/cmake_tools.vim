" Vim plug-in to add a bunch of functionality related to CMake development.
" Last Change:  2019 July 16
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_cmake_tools')
  finish
endif
let b:loaded_cmake_tools = 1

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

setlocal colorcolumn=81
setlocal foldenable                " turn on code folding
setlocal foldmethod=syntax         " use the marker method for folding
setlocal foldtext=CMakeFoldText()  " use my function to build the fold text

" the comment/uncomment plug-in
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

" A function to run cmakelint on the current file.
setlocal makeprg=cmakelint\ --spaces=2\ %:p
function! CmakeRunCmakelint()
  if &diff == 0
    make
  endif
endfunction
if !hasmapto('<Plug>CMakelint')
  map <buffer> <unique> <Leader>l <Plug>CMakelint
endif
noremap <buffer> <unique> <script> <Plug>CMakelint :call CmakeRunCmakelint()<CR>

augroup CMakeLintChecks
  autocmd BufWritePost,FileWritePost <buffer> call CmakeRunCmakelint()
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
augroup end
