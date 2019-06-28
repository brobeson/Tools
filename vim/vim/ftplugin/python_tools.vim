" Vim plug-in to add a bunch of functionality related to Python development.
" Last Change:  2019 June 28
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_python_tools')
    finish
endif
let b:loaded_python_tools = 1

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

setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
if &diff
  "autocmd BufWritePost,FileWritePost <buffer> execute '!black %:p'
  "autocmd BufWritePost,FileWritePost <buffer> normal zv 
  autocmd BufWritePost,FileWritePost <buffer> make
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
endif

setlocal colorcolumn=81

" A function, command, and map to run Black on the current file. Black is a
" formatting tool for Python files.
function! PythonRunFormatter()
  if &diff == 0
    execute '!black %:p'
  endif
endfunction
if !hasmapto('<Plug>PythonRunFormatter')
  map <buffer> <unique> <Leader>f <Plug>Format
endif
noremap <buffer> <unique> <script> <Plug>Format :call PythonRunFormatter()<CR>
