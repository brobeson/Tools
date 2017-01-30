" Vim plug-in to add a bunch of functionality related to Groovy development.
" Last Change:  2017 January 30
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
" do this AFTER setting up code folding. I found that if I close a C++ buffer,
" then reopen it, the fold settings are all screwed up
if exists('b:loaded_groovy_tools')
    finish
endif
let b:loaded_groovy_tools = 1

" the comment/uncomment plug-in
if !exists('*Comment') || !exists('*Uncomment')
    echoerr 'Command() or Uncomment() is undefined. Do you have plug-in/codeTools.vim loaded?'
else
    " map the comment command
    if !hasmapto('<Plug>GroovyComment')
        map <buffer> <unique> <Leader>c <Plug>GroovyComment
    endif
    noremap  <buffer> <unique> <script> <Plug>GroovyComment :call Comment('//')<CR>

    " map the uncomment command
    if !hasmapto('<Plug>GroovyUncomment')
        map <buffer> <unique> <Leader>u <Plug>GroovyUncomment
    endif
    noremap  <buffer> <unique> <script> <Plug>GroovyUncomment :call Uncomment('//')<CR>
endif

