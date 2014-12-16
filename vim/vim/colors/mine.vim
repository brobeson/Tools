" First remove all existing highlighting.
highlight clear

let colors_name = "mine"

highlight Normal ctermfg=white ctermbg=black guifg=white guibg=black

" Groups used in the 'highlight' and 'guicursor' options default value.
highlight ColorColumn   cterm=none                        ctermbg=DarkRed  gui=none                     guibg=DarkRed
"Conceal
highlight Cursor                                                                        guifg=fg        guibg=fg
"CursorColumn
"CursorIM
"CursorLine
highlight Directory                    ctermfg=DarkBlue                                 guifg=Blue
highlight Error                        ctermfg=White      ctermbg=DarkRed               guifg=White     guibg=Red
highlight ErrorMsg                     ctermfg=White      ctermbg=DarkRed               guifg=White     guibg=Red
highlight Folded                       ctermfg=DarkGray   ctermbg=Black                 guifg=Magenta   guibg=Black
highlight FoldColumn                   ctermfg=White      ctermbg=Black                 guifg=White     guibg=black
highlight IncSearch     cterm=reverse                                      gui=reverse
highlight LineNr                       ctermfg=Brown                                    guifg=Brown
"MatchParen
highlight ModeMsg       cterm=bold                                         gui=bold
highlight NonText                      ctermfg=Blue                        gui=bold     guifg=gray      guibg=white
"Pmenu
"PmenuSbar
"PmenuSel
"PmenuThumb
highlight Question                     ctermfg=DarkGreen                   gui=bold     guifg=SeaGreen
highlight Search        ctermbg=White
"SignColumn
highlight SpecialKey                   ctermfg=DarkBlue                                 guifg=Blue
"SpellBad
"SpellCap
"SpellLocal
"SpellRare
highlight StatusLine    cterm=bold     ctermfg=Yellow     ctermbg=blue                  guifg=Blue      guibg=gold
highlight StatusLineNC  cterm=bold     ctermfg=Black      ctermbg=blue                  guifg=Blue      guibg=gold
highlight VertSplit     cterm=reverse                                      gui=reverse
highlight WildMenu                     ctermfg=Black      ctermbg=Yellow                guifg=Black     guibg=Yellow

" tabline groups have no effect in the GUI
"TabLine
"TabLineFill
"TabLineSel

" linux GUI options
"Menu
"Scrollbar
"Tooltip

" syntax highlighting
highlight Comment     cterm=none  ctermfg=Magenta     gui=none  guifg=Magenta
highlight Constant    cterm=none  ctermfg=LightGreen  gui=none  guifg=LightGreen
"Boolean
"Character
"Float
"Number
"String
highlight Identifier  cterm=none  ctermfg=Cyan        gui=none  guifg=Cyan
"Function
highlight PreProc     cterm=none  ctermfg=DarkGreen   gui=none  guifg=DarkGreen
"Define
"Include
"Macro
"PreCondit
highlight Special     cterm=none  ctermfg=Yellow      gui=none  guifg=Yellow
"SpecialChar
"Debug
"Delimiter
"SpecialComment
"Tag
highlight Statement   cterm=bold  ctermfg=DarkCyan    gui=none  guifg=DarkCyan
"Conditional
"Exception
"Keyword
"Label
highlight Operator                ctermfg=DarkCyan    gui=none  guifg=pink
"Repeat
"Todo
highlight Type        cterm=none  ctermfg=DarkCyan    gui=none  guifg=DarkCyan
"StorageClass
"Structure
"Typedef
"Underlined

" custom groups
"htmlAttributeNameGrp
"htmlEntityGrp
"urlGrp

" diff
highlight DiffAdd                                         ctermbg=LightBlue                           guibg=LightBlue
highlight DiffChange                                      ctermbg=LightMagenta                        guibg=LightMagenta
highlight DiffDelete                        ctermfg=Blue  ctermbg=LightCyan     gui=bold  guifg=Blue  guibg=LightCyan
highlight DiffText    cterm=bold                          ctermbg=Red           gui=bold  guibg=Red

" old
highlight lCursor                                                                    guifg=none      guibg=Cyan
highlight MoreMsg                           ctermfg=DarkGreen    gui=bold            guifg=SeaGreen
highlight Title                             ctermfg=DarkMagenta  gui=bold            guifg=Magenta
highlight Visual      cterm=reverse                              gui=reverse         guifg=Grey      guibg=fg
highlight VisualNOS   cterm=underline,bold                       gui=underline,bold
highlight WarningMsg                        ctermfg=DarkRed                          guifg=Red

if exists("syntax_on")
  let syntax_cmd = "enable"
  runtime syntax/syncolor.vim
  unlet syntax_cmd
endif

" vim: sw=2
