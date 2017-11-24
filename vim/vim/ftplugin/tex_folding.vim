" Vim plug-in to add a LaTeX code folding
" Last Change:  2017 November 24
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)

let tex_fold_enabled = 1    " :help tex-folding

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
setlocal foldmarker=start_fold_,end_fold
setlocal foldtext=LatexFoldText()

