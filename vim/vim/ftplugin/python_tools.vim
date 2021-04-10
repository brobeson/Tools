" Vim plug-in to add a bunch of functionality related to Python development.
" Last Change:  2020 January 20
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

setlocal colorcolumn=101
setlocal textwidth=100

" A function and map to run Black on the current file. Black is a formatting
" tool for Python files.
function! PythonRunFormatter()
  if &diff == 0
    execute '!black %:p'
  endif
endfunction
if !hasmapto('<Plug>Formatter')
  map <buffer> <unique> <Leader>f <Plug>Format
endif
noremap <buffer> <unique> <script> <Plug>Format :call PythonRunFormatter()<CR>

" A function and map to run Python lint tools on the current file.
compiler pylint
function! PythonRunLinters()
  if &diff == 0
    make %:p
  endif
endfunction
if !hasmapto('<Plug>Lint')
  map <buffer> <unique> <Leader>l <Plug>Lint
endif
noremap <buffer> <unique> <script> <Plug>Lint :call PythonRunLinters()<CR>

" On write, run linters.
augroup PythonLintChecks
  " TODO After finishing PhD research, run formatting on write.
  "autocmd BufWritePost,FileWritePost <buffer> call PythonRunFormatter()
  "  \ | call PythonRunLinters()
  autocmd BufWritePost,FileWritePost <buffer> call PythonRunLinters()
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
augroup end

function! RunPython()
  new | read !python3 %:p
endfunction
if !hasmapto('<Plug>PythonRunner')
  map <buffer> <unique> <Leader>R <Plug>PythonRunner
endif
noremap <buffer> <unique> <script> <Plug>PythonRunner :call RunPython()<CR>

