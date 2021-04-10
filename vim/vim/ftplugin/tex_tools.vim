" Vim plug-in to add a bunch of functionality related to LaTeX development.
" Last Change:  2020 February 14
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

command -buffer Render w|make

function! RunLacheck()
  if &diff != 0
    return
  endif
  let original_makeprg = &makeprg
  setlocal makeprg=lacheck\ %:p
  make
  let &makeprg = original_makeprg
endfunction

function! RunChktex()
  if &diff != 0
    return
  endif
  let original_makeprg = &makeprg
  setlocal makeprg=chktex\ -v0\ %:p
  make
  let &makeprg = original_makeprg
endfunction

function! RunCheckWriting()
  if &diff != 0
    return
  endif
  let original_makeprg = &makeprg
  setlocal makeprg=checkwriting\ -v\ %:p
  make
  let &makeprg = original_makeprg
endfunction

function! RunLint()
  if &diff != 0
    return
  endif
  call RunChktex()
  let quickfix_list = getqflist()
  call RunLacheck()
  call setqflist(quickfix_list, 'a')
endfunction

if !hasmapto('<Plug>LatexLint')
  map <buffer> <unique> <Leader>l <Plug>LatexLint
endif
noremap <buffer> <unique> <script> <Plug>LatexLint :call RunLint()<CR>
command -buffer Lint call RunLint

augroup LatexLintChecks
  "autocmd BufWritePost,FileWritePost <buffer> call RunLint()
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup end

setlocal spellfile=en.utf-8.add

function! InsertSentence()
  execute 'normal I\trackInsertion{'
  execute 'normal $a}'
endfunction
if !hasmapto('<Plug>InsertSentence')
  map <buffer> <unique> <Leader>I :call InsertSentence()<CR>
endif

function! InsertMeetingSentence()
  execute 'normal I\meetingEdit{'
  execute 'normal $a}'
endfunction
if !hasmapto('<Plug>InsertMeetingSentence')
  map <buffer> <unique> <Leader>E :call InsertMeetingSentence()<CR>
endif
