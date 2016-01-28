" Vim plug-in to add a bunch of functionality related to Vim scripting.
" Last Change:  2016 January 19
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)
"
" [1]           Some functions are from http://peterodding.com/code/vim/profile/vimrc
"               There's some good stuff in there!

" I don't know why, but these need to be set prior to finishing. otherwise
" they may not set correctly if the file is closed, then reopened.
setlocal foldenable                 " turn on code folding
setlocal foldmethod=marker          " use the marker method for folding
setlocal foldtext=MarkerFoldText()  " use my function to build the fold text

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_vim_tools')
    finish
endif
let b:loaded_vim_tools = 1

" Automatic updating of 'Last Change:' comments [1] {{{
" I modified the function a bit...
" 1) use variable names that make more sense to me
" 2) add some comments
" 3) change the date format to YYYY Month dd
" 4) preserve all space between 'Last Changed' and the date
if !exists('*s:update_last_change_date') && exists('*strftime')
    function s:update_last_change_date()
        let pattern = '\<Last Change:\s\+\zs.*'

        " get the line number of the 'last change' text. getline() will return a
        " list, then match() will return a 0-based index into the list. add 1 to
        " get it back to the line number. match() returns -1 if no match is
        " found, thus we can check for >0 after adding 1
        let line_number = match(getline(1, 10), pattern) + 1
        if line_number > 0
            let current_line = getline(line_number)

            " determine today's date as a string. the substitute removes the
            " extra space preceding the day (%e).
            let new_date = substitute(strftime('%Y %B %e'), '\s\{2,}', ' ', 'g')

            " change the date and modify the line in the buffer
            let new_line = substitute(current_line, pattern, new_date, '')
            if new_line !=# current_line
                undojoin
                keepjumps call setline(line_number, new_line)
            endif
        endif
    endfunction
endif
autocmd BufWritePre * call s:update_last_change_date()
" }}}

" the comment/uncomment plug-in {{{
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " create the command mappings to call the functions
    if !exists('no_plug-in_maps') && !exists('no_vim_maps')
        " map the comment command
        if !hasmapto('<Plug>VimComment')
            map <buffer> <unique> <Leader>c <Plug>VimComment
        endif
        noremap  <buffer> <unique> <script> <Plug>VimComment :call Comment('"')<CR>

        " map the uncomment command
        if !hasmapto('<Plug>VimUncomment')
            map <buffer> <unique> <Leader>u <Plug>VimUncomment
        endif
        noremap  <buffer> <unique> <script> <Plug>VimUncomment :call Uncomment('"')<CR>
    endif
endif
"}}}

