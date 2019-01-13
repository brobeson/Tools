" Vim indent file
" Language:	    Jenkins Declarative Pipeline
" Maintainer:	brobeson <https://github.com/brobeson/Tools>
" Last Change:	2018 January 29

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Jenkins Declarative Pipeline indenting is similar to C. Start with that.
setlocal cindent

let b:undo_indent = "setl cin<"

