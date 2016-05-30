" Vim indent file
" Language:     OpenGL Shading Language (GLSL)
" Maintainer:   Brendan Robeson (https://github.com/brobeson/glslVim)
" Last Change:  2015 August 6
"
" GLSL is like C in structure. Borrowing from indent/c.vim, I'm just enabling
" cindent.

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
   finish
endif
let b:did_indent = 1

" C indenting is built-in, thus this is very simple
setlocal cindent

let b:undo_indent = "setl cin<"
