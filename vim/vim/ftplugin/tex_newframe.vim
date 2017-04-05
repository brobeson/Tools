" Vim plug-in to stub in a new frame for a Beamer presentation
" Last Change:  2017 April 2
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_tex_newframe')
    finish
endif
let b:loaded_tex_newframe = 1

" map the new frame command
if !hasmapto('<Plug>TexNewFrame')
    map <buffer> <unique> <Leader>f <Plug>TexNewFrame
endif
noremap  <buffer> <unique> <script> <Plug>TexNewFrame :call <SID>NewFrame()<CR>

if !exists('s:tex_new_frame_declaration')
    let s:tex_new_frame_declaration = [
                \ '\begin{frame}',
                \ '\frametitle{frame_title}',
                \ '',
                \ '\end{frame}',
                \ '' ]
    let s:tex_new_frame_declaration_length = len(s:tex_new_frame_declaration) + 1
endif

" define the function to create a new frame
if !exists('*s:NewFrame')
    function s:NewFrame()
        let start_line = line('.')

        " ask the user for a frame title
        let frame_title = input('enter a title for the frame: ')

        " build up the frame mark up
        let frame_declaration = []
        for line in s:tex_new_frame_declaration
            call add(frame_declaration, substitute(line, 'frame_title', frame_title, 'g'))
        endfor

        " add it to the buffer and reformat it
        call append(line('.'), frame_declaration)
        execute 'silent normal' s:tex_new_frame_declaration_length . "=="

        " move to the blank line and end edit mode
        normal jjj
        startinsert!
    endfunction
endif

