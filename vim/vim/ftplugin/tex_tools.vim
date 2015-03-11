" Vim plugin to add a bunch of functionality related to LaTeX development.
" Last Change:	2015 March 8
" Maintainer:  Brendan Robeson (ogslanger@vt.edu)
" License:     Public Domain
"
"  - add my code folding text and fold settings
"  - add functionality to comment and uncomment a range of lines

" check if this plugin (or one with the same name) has already been loaded
if exists("b:loaded_latex")
	finish
endif
let b:loaded_latex = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim


" load the general code editing tools
runtime codeTools.vim


set noautoindent
set nocindent
set nosmartindent
set cursorline


"==============================================================================
" code folding {{{
"==============================================================================
" i'm not sure why, but i can't make this a script local function. if i do,
" then using set foldtext=<SID>LatexFoldText, then the folding doesn't display
" correctly.
if !exists("*LatexFoldText")
	function LatexFoldText()
		let firstLineNum = v:foldstart
		let firstLine = getline(firstLineNum)
		let markerText = substitute(&foldmarker, ',.*', '', '')

		" if the first line is a comment, then just use the comment text
		if -1 != match(firstLine, '^\s*%.\+' . markerText, '', '')
			let foldText = substitute(firstLine, '%\s*', '', '')
			let foldText = substitute(foldText, markerText, '', '')
			let foldText .= "..."

		" if the first line is not a comment, get the line which starts a LaTeX
		" command (\begin, \section, etc).
		else
			while (firstLineNum <= v:foldend) && (match(firstLine, '\\\a\+\*\?{', '', '') == -1)
				let firstLineNum = firstLineNum + 1
				let firstLine = getline(firstLineNum)
			endwhile

			" if a valid first line was not found
			if v:foldend < firstLineNum
				let foldText = "no LaTeX comment found"

			" otherwise, we do have the LaTeX command
			else
				let cmd = matchstr(firstLine, '\s*\\\a\+\*\?{.*}', '', '')
				let foldText = cmd . "..."

				if (0 <= match(cmd, '\begin', '', ''))
					let foldText .= matchstr(cmd, '{.*}', '', '')
				endif
			endif
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
setlocal foldmethod=marker
setlocal foldtext=LatexFoldText()
setlocal fillchars=fold:\ 
"}}}


"==============================================================================
" the comment/uncomment plugin {{{
"==============================================================================
" create the command mappings to call the functions
if !exists("no_plugin_maps") && !exists("no_latex_maps")
	" map the comment command
	if !hasmapto('<Plug>LatexComment')
		map <buffer> <unique> <Leader>c <Plug>LatexComment
	endif
	noremap  <buffer> <unique> <script> <Plug>LatexComment <SID>Comment
	noremap  <buffer>                   <SID>Comment     :call Comment("%")<CR>

	" map the uncomment command
	if !hasmapto('<Plug>LatexUncomment')
		map <buffer> <unique> <Leader>u <Plug>LatexUncomment
	endif
	noremap  <buffer> <unique> <script> <Plug>LatexUncomment <SID>Uncomment
	noremap  <buffer>                   <SID>Uncomment     :call Uncomment("%")<CR>
endif
noremenu <script> &Latex.&Comment   <SID>Comment
noremenu <script> &Latex.&Uncomment <SID>Uncomment
"}}}


" restore the original cpoptions
let &cpo = s:save_cpo

