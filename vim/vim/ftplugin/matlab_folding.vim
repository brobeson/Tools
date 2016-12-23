" Vim plug-in to add a LaTeX code folding
" Last Change:  2016 November 20
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)

if !exists('*MatlabFoldText')
    function MatlabFoldText()
        let first_line_number = v:foldstart
        let first_line = getline(first_line_number)
        let marker_text = substitute(&foldmarker, ',.*', '', '')

        " if the first line is a comment, then just use the comment text
        let fold_text = substitute(first_line, '%\s*', '', '')
        let fold_text = substitute(fold_text, marker_text, '', '')
        let fold_text .= '...'

        " Vim sets the tab character to 1 space in the fold text.  I want
        " the braces to remain aligned as in the code, so swap out the
        " tabs for enough spaces to match the tab stop
        let spaces = repeat(' ', &tabstop)
        let fold_text = substitute(fold_text, '\t', spaces, 'g')

        return fold_text
    endfunction
endif

" turn on folding, use the marker method, and use my function to generate the
" fold text
setlocal foldenable
setlocal foldmethod=marker
setlocal foldtext=MatlabFoldText()

