" Vim plugin to add a bunch of functionality related to bash development.
" Last Change:	2015 March 8
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)
" License:		Public Domain
"
"  - add my code folding text and fold settings
"  - add functionality to comment and uncomment a range of lines

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_sh')
	finish
endif
let b:loaded_sh = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim


"==============================================================================
" code folding {{{
"==============================================================================
" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. i'm not sure why, but i can't make
" this a script local function. if i do, then use 'set foldtext=<SID>CppFoldText',
" then the folding doesn't display correctly.
if !exists('*CppFoldText')
	function CppFoldText()
		" start by folding a doxygen comment
		let foldText = ''
		if exists('*FoldDoxygen')
			let foldText = FoldDoxygen()
		endif

		" if the folded block isn't a doxygen comment, the function will
		" return '' and we can try other blocks.
		if foldText == ''
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
setlocal foldtext=CppFoldText()
setlocal fillchars=fold:\ 
"}}}


"==============================================================================
" the comment/uncomment plugin {{{
"==============================================================================
if !exists('*Comment') || !exists('*Uncomment')
	echoerr 'Command() or Uncomment() is undefined. Do you have plugin/codeTools.vim loaded?'
else
	" create the command mappings to call the functions
	if !exists('no_plugin_maps') && !exists('no_cpp_maps')
		" map the comment command
		if !hasmapto('<Plug>CppComment')
			map <buffer> <unique> <Leader>c <Plug>CppComment
		endif
		noremap  <buffer> <unique> <script> <Plug>CppComment :call Comment('#')<CR>

		" map the uncomment command
		if !hasmapto('<Plug>CppUncomment')
			map <buffer> <unique> <Leader>u <Plug>CppUncomment
		endif
		noremap  <buffer> <unique> <script> <Plug>CppUncomment :call Uncomment('#')<CR>
	endif
endif
"}}}


" restore the original cpoptions
let &cpo = s:save_cpo

