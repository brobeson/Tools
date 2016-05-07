" Vim plug-in to add a bunch of functionality related to bash development.
" Last Change:	2016 May 6
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_sh_tools')
	finish
endif
let b:loaded_sh_tools = 1

let is_bash = 1 " :help ft-bash-syntax

" code folding {{{
" the fold text function
if !exists('*BashFoldText')
    function BashFoldText()
        if &diff
            let fold_text = printf('[ %5d identical lines ]', v:foldend - v:foldstart + 1)
        else
            " get the first line. it's needed to determine what type of fold
            " text to create
            let first_line = getline(v:foldstart)

            " start with leading white space
            let fold_text = substitute(first_line, '\S\+.*', '', '')

            " vim sets the tab character to 1 space in the fold text. I want the
            " fold text to remain aligned as in the code, so swap out tabs for
            " enough spaces to match the tabstop
            let spaces = repeat(' ', &tabstop)
            let fold_text = substitute(fold_text, '\t', spaces, 'g')

            " append '[ NNNNN lines ] <comment text with leading white space, '"', or trailing fold marker>
            " the marker_text variable get the beginning fold marker so it can
            " be extracted from the fold text. this has two advantages:
            " 1) if a user chane their fold marker text, this accounts for that,
            " 2) it avoids an unwanted fold starting here in this file.
            let fold_text .= printf('[ %5d lines ] ', v:foldend - v:foldstart + 1)
            let fold_text .= substitute(first_line, '^\s*#\s*', '', '')
            let marker_text = substitute(&foldmarker, ',.*', '', '')
            let fold_text = substitute(fold_text, marker_text, '', '')
            let fold_text .= '...'
        endif
        return fold_text
    endfunction
endif

setlocal foldenable               " turn on code folding
setlocal foldmethod=marker        " use the marker method for folding
setlocal foldtext=BashFoldText()  " use my function to build the fold text
" }}}

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

