" Vim file type plug-in file
" Language:     OpenGL Shading Language (GLSL)
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:  2015 December 30

" Only do this when not done yet for this buffer
if exists('b:did_ftplug-in')
    finish
endif

" Using line continuation here.
let s:cpo_save = &cpo
set cpo-=C

" TODO  add the undo for ofu after autoloading functions are added to GLSL
"let b:undo_ftplug_in = 'setl fo< com< ofu<'
let b:undo_ftplug_in = 'setl formatoptions< comments< foldmethod<'

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using 'o'.
setlocal formatoptions-=t formatoptions+=croql

" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
    setlocal ofu=glslcomplete#Complete
endif

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" When the matchit plug-in is loaded, this makes the % command skip parentheses
" and braces in comments.
let b:match_words = &matchpairs . ',^\s*#\s*if\(\|def\|ndef\)\>:^\s*#\s*elif\>:^\s*#\s*else\>:^\s*#\s*endif\>'
let b:match_skip = 's:comment\|string\|character'

" set up code folding
setlocal foldmethod=syntax

" files in the browse dialog
if (has('gui_win32') || has('gui_gtk')) && !exists('b:browsefilter')
    let b:browsefilter = 'GLSL Source Files (*.glsl)\t*.glsl\n' .
                       \ 'All Files (*.*)\t*.*\n'
endif

" enable syntax highlighting in the preview window
autocmd BufWinEnter * if &previewwindow | set filetype=glsl | endif

" code folding {{{
" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. i'm not sure why, but i can't make
" this a script local function. if i do, then use 'set
" foldtext=<SID>GlslFoldText',
" then the folding doesn't display correctly.
if !exists('*GlslFoldText')
    function GlslFoldText()
        " get the first line. we need it to determine what type of fold text
        " to create. also initialize the fold text in a way to indicate a
        " folding case I haven't handled.
        let firstLine = getline(v:foldstart)
        let foldText = 'NO FOLD TEXT DEFINED'

        " 'commented' code via #if 0, or #ifdef 0
        if match(firstLine, '^\s*#if\(def\)\?\s*0') == 0
            let codeLine = getline(v:foldstart + 1)
            let spaceCount = match(codeLine, '\S')
            let foldText = repeat(' ', spaceCount) . '[ commented code ]  '
            let foldText .= substitute(codeLine, '^\s*', '', '')

        " code blocks
        elseif match(firstLine, '{') != -1
            " remove text following the block's opening '{'. it's not just set
            " to a brace, because we want to keep the leading white space so
            " the fold text remains aligned with the block identifier
            " (function name, class name, etc).
            let foldText = substitute(firstLine, '{.*', '{', '')

            " the fill text is the number of folded lines, right justified
            let foldText .= printf(' %5d lines }', v:foldend - v:foldstart + 1)
        endif

        " vim sets the tab character to 1 space in the fold text.  I want
        " the braces to remain aligned as in the code, so swap out the
        " tabs for enough spaces to match the tabstop
        let spaces = repeat(' ', &tabstop)
        let foldText = substitute(foldText, '\t', spaces, 'g')
        return foldText
    endfunction
endif

" turn on folding, remove the fold column, use the syntax method, use my
" function to generate the fold text, and make the fill character a space
setlocal foldenable
setlocal foldcolumn=0
setlocal foldmethod=syntax
setlocal foldtext=GlslFoldText()
setlocal fillchars=fold:\ 
"}}}

" the comment/uncomment plug-in {{{
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " create the command mappings to call the functions
    if !exists('no_plug-in_maps') && !exists('no_glsl_maps')
        " map the comment command
        if !hasmapto('<Plug>GlslComment')
            map <buffer> <unique> <Leader>c <Plug>GlslComment
        endif
        noremap  <buffer> <unique> <script> <Plug>GlslComment :call Comment('//')<CR>

        " map the uncomment command
        if !hasmapto('<Plug>GlslUncomment')
            map <buffer> <unique> <Leader>u <Plug>GlslUncomment
        endif
        noremap  <buffer> <unique> <script> <Plug>GlslUncomment :call Uncomment('//')<CR>
    endif
endif
"}}}

setlocal expandtab

let &cpo = s:cpo_save
unlet s:cpo_save
