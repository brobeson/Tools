" Vim plug-in to add a bunch of functionality related to LaTeX development.
" Last Change:  2015 December 16
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_tex_tools')
    finish
endif
let b:loaded_tex_tools = 1

" set some variables and local options {{{
let tex_flavor = 'latex'    " :help ft-tex-plug-in
let tex_fold_enabled = 1    " :help tex-folding
setlocal noautoindent
setlocal nocindent
setlocal nosmartindent
setlocal cursorline
"}}}

" code folding {{{
if !exists('*LatexFoldText')
    function LatexFoldText()
        let first_line_number = v:foldstart
        let first_line = getline(first_line_number)
        let marker_text = substitute(&foldmarker, ',.*', '', '')

        " if the first line is a comment, then just use the comment text
        if -1 != match(first_line, '^\s*%.\+' . marker_text, '', '')
            let fold_text = substitute(first_line, '%\s*', '', '')
            let fold_text = substitute(fold_text, marker_text, '', '')
            let fold_text .= '...'

        " if the first line is not a comment, get the line which starts a LaTeX
        " command (\begin, \section, etc.)
        else
            while (first_line_number <= v:foldend) && (match(first_line, '\\\a\+\*\?{', '', '') == -1)
                let first_line_number = first_line_number + 1
                let first_line = getline(first_line_number)
            endwhile

            " if a valid first line was not found
            if v:foldend < first_line_number
                let fold_text = 'no LaTeX comment found'

            " otherwise, we do have the LaTeX command
            else
                let cmd = matchstr(first_line, '\s*\\\a\+\*\?{.*}', '', '')
                let fold_text = cmd . '...'

                if (0 <= match(cmd, '\begin', '', ''))
                    let fold_text .= matchstr(cmd, '{.*}', '', '')
                endif
            endif
        endif

        " Vim sets the tab character to 1 space in the fold text.  I want
        " the braces to remain aligned as in the code, so swap out the
        " tabs for enough spaces to match the tab stop
        let spaces = repeat(' ', &tabstop)
        let fold_text = substitute(fold_text, '\t', spaces, 'g')

        return fold_text
    endfunction
endif

" turn on folding, remove the fold column, use the syntax method, use my
" function to generate the fold text, and make the fill character a space
setlocal foldenable
setlocal foldmethod=marker
setlocal foldtext=LatexFoldText()
"}}}

" the comment/uncomment plug-in {{{
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
"}}}

