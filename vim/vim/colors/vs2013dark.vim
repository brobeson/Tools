" Vim color file
" Maintainer: Brendan Robeson <ogslanger@vt.edu>
" Last Change: 2014 October 3
" License:  Public Domain
"
" This color file is meant to mimic Visual Studio 2013's C++ highlighting for
" the dark UI color scheme. An exact match for Vim launched in MS-DOS and
" xterm windows isn't possible due to color limitations. For cterm*, I tried
" to get as close as possible.  Also, I darkened the GUI background a bit; I
" found it too light on my Windows machine (I haven't checked on my Linux box
" yet).
"
" Change History
" 2014 Oct 3  initial version

" First remove all existing highlighting.
highlight clear

let colors_name = "vs2013dark"

highlight Normal ctermfg=white ctermbg=black guifg=#dcdcdc guibg=#131313

" Groups used in the 'highlight' and 'guicursor' options default value.
" new
" TODO on windows, cterm has no effect.  check on linux
" TODO the cursor apparently can't be changed in dos. check it on linux
highlight ColorColumn   cterm=none                     ctermbg=darkred   gui=none                       guibg=darkred
"Conceal
highlight Cursor        cterm=none                                                      guifg=bg        guibg=fg
highlight CursorColumn  cterm=none                     ctermbg=darkgray  gui=none                       guibg=black
"CursorIM
highlight CursorLine    cterm=none                     ctermbg=darkgray  gui=none                       guibg=black
highlight Directory     cterm=none  ctermfg=darkgray                     gui=none       guifg=#808080
highlight Error         cterm=none  ctermfg=lightgray  ctermbg=darkred   gui=underline  guifg=darkred   guibg=bg
highlight ErrorMsg      cterm=none  ctermfg=white      ctermbg=darkred                  guifg=white     guibg=darkred
highlight Folded        cterm=none  ctermfg=darkgray   ctermbg=bg                       guifg=#808080   guibg=bg
highlight FoldColumn    cterm=none  ctermfg=darkgray   ctermbg=bg                       guifg=#808080   guibg=bg
highlight IncSearch     cterm=none  ctermfg=bg         ctermbg=fg        gui=none       guifg=bg        guibg=fg
highlight LineNr        cterm=none  ctermfg=darkcyan                                    guifg=#2b91af
highlight MatchParen    cterm=none                     ctermbg=blue      gui=none                       guibg=#0e4583
highlight ModeMsg       cterm=none                                       gui=none
highlight NonText       cterm=none  ctermfg=fg         ctermbg=bg        gui=none       guifg=fg        guibg=bg
"Pmenu
"PmenuSbar
"PmenuSel
"PmenuThumb
highlight Question      cterm=none  ctermfg=green                        gui=none       guifg=seagreen
highlight Search        cterm=none  ctermfg=bg         ctermbg=darkgray  gui=none       guifg=bg        guibg=darkgray
"SignColumn
highlight SpecialKey    cterm=none  ctermfg=white                                       guifg=white
"SpellBad
"SpellCap
"SpellLocal
"SpellRare
highlight StatusLine    cterm=none  ctermfg=fg         ctermbg=darkgray  gui=none       guifg=fg        guibg=bg
highlight StatusLineNC  cterm=none  ctermfg=darkgray   ctermbg=bg        gui=none       guifg=darkgray  guibg=bg
highlight VertSplit     cterm=none  ctermfg=darkgray   ctermbg=darkgray                 guifg=#808080   guibg=#808080
highlight WildMenu      cterm=none  ctermfg=black      ctermbg=darkgray  gui=underline  guifg=fg        guibg=bg

" tabline groups have no effect in the GUI
highlight TabLine      cterm=none  ctermfg=darkgray  ctermbg=bg
highlight TabLineFill  cterm=none                    ctermbg=bg
highlight TabLineSel   cterm=none  ctermfg=fg        ctermbg=bg

" linux GUI options
" Menu
" Scrollbar
" Tooltip

" syntax highlighting
" TODO Identifier may need a color distinct from Function
" TODO Identifier and Function may be too indistinct from normal text in the GUI.
highlight Comment      cterm=none  ctermfg=darkgreen                    gui=none       guifg=#57a64a
highlight Constant     cterm=none  ctermfg=darkyellow                   gui=none       guifg=#d69d85
highlight Boolean      cterm=none  ctermfg=cyan                         gui=none       guifg=#569cd6
highlight Character    cterm=none  ctermfg=darkyellow                   gui=none       guifg=#d69d85
highlight Float        cterm=none  ctermfg=lightgreen                   gui=none       guifg=#b5cea8
highlight Number       cterm=none  ctermfg=lightgreen                   gui=none       guifg=#b5cea8
highlight String       cterm=none  ctermfg=darkyellow                   gui=none       guifg=#d69d85
highlight Identifier   cterm=none  ctermfg=lightgray                    gui=none       guifg=#c8c8c8
highlight Function     cterm=none  ctermfg=lightgray                    gui=none       guifg=#c8c8c8
"Ignore
highlight PreProc      cterm=none  ctermfg=gray                         gui=none       guifg=#9b9b9b
"Define    \
"Include    \  VS 2013 has all preprocessor directives the same color
"Macro      /
"PreCondit /
highlight Special      cterm=none  ctermfg=darkyellow                   gui=none       guifg=#d69d85
highlight SpecialChar  cterm=none  ctermfg=darkyellow                   gui=none       guifg=#d69d85
"Debug         \
"Delimiter      \ vim's c/c++ syntax doesn't use these
"SpecialComment /
"Tag           /
highlight Statement    cterm=bold  ctermfg=darkcyan                     gui=none       guifg=#569cd6
"Conditional \
"Exception    \
"Keyword       \ VS 2013 lumps all the keywords together
"Label         /
"Operator     /
"Repeat      /
highlight Todo         cterm=none  ctermfg=black       ctermbg=darkcyan gui=none       guifg=black    guibg=#92caf4
highlight Type         cterm=bold  ctermfg=darkcyan                     gui=none       guifg=#569cd6
"StorageClass \
"Structure     \ VS 2013 lumps all the type infomation with keywords
"Typedef       /
highlight Underlined   cterm=none ctermfg=darkcyan                      gui=underline  guifg=#569cd6

" custom groups
highlight htmlAttributeNameGrp cterm=none ctermfg=darkcyan gui=none      guifg=#9cdcfe guibg=bg
highlight htmlEntityGrp        cterm=none ctermfg=darkcyan gui=none      guifg=#00a0a0 guibg=bg
highlight urlGrp               cterm=none ctermfg=darkcyan gui=underline guifg=#569cd6 guibg=bg

" diff
" i don't use VS 2013 for diff, nor do I have diff capability in vim. so i
" just copied this verbatim and didn't check it.
highlight DiffAdd     cterm=none  ctermfg=green      ctermbg=darkgreen  gui=none  guifg=#76923c  guibg=#265e4d
highlight DiffChange  cterm=none  ctermbg=green                                                  guibg=#296958
highlight DiffDelete  cterm=none  ctermfg=red        ctermbg=darkred    gui=none  guifg=#ff6666  guibg=#3c0000
highlight DiffText    cterm=none  ctermbg=darkgreen                     gui=none                 guibg=#15352c

" old
highlight lCursor                                                               guifg=NONE      guibg=cyan
highlight MoreMsg                           ctermfg=darkgreen                   guifg=Seagreen
highlight Title                             ctermfg=darkmagenta  gui=none       guifg=magenta
highlight Visual      cterm=reverse                              gui=reverse    guifg=Grey      guibg=fg
highlight VisualNOS   cterm=underline,bold                       gui=underline
highlight WarningMsg                        ctermfg=darkred                     guifg=red

if exists("syntax_on")
  let syntax_cmd = "enable"
  runtime syntax/syncolor.vim
  unlet syntax_cmd
endif

" vim: sw=2
