" Vim plugin to add a bunch of functionality related to Vim scripting.
" Last Change:	2015 March 8
" Maintainer:  Brendan Robeson (ogslanger@vt.edu)
" License:     Public Domain
"
"  - add my code folding text and fold settings
"  - add functionality to comment and uncomment a range of lines

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_vim')
	finish
endif
let b:loaded_vim = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim


"==============================================================================
" code folding {{{
"==============================================================================
" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. i'm not sure why, but i can't make
" this a script local function. if i do, then using
" set foldtext=<SID>VimFoldText, then the folding doesn't display correctly.
if !exists('*VimFoldText')
	function VimFoldText()
		if &diff
			let foldText = printf('[ %5d identical lines ]', v:foldend - v:foldstart + 1)
		else
			" get the first line. we need it to determine what type of fold text
			" to create.
			let firstLine = getline(v:foldstart)

			" start with the leading white space
			let foldText = substitute(firstLine, '\S\+.*', '', '')

			" vim sets the tab character to 1 space in the fold text.  I want
			" the braces to remain aligned as in the code, so swap out the
			" tabs for enough spaces to match the tabstop
			let spaces = repeat(' ', &tabstop)
			let foldText = substitute(foldText, '\t', spaces, 'g')

			" append '[ NNNNN lines ]    <comment text with leading white space, '"', or trailing fold marker>
			" the markerText variable gets the beginning fold marker so it can be
			" extracted from the fold text. this has two advantages:
			" 1) if a user changes their fold marker text, this accounts for that,
			" 2) it avoids an unwanted fold starting here in this file.
			let foldText .= printf('[ %5d lines ]    ', v:foldend - v:foldstart + 1)
			let foldText .= substitute(firstLine, '^\s*"\s*', '', '')
			let markerText = substitute(&foldmarker, ',.*', '', '')
			let foldText = substitute(foldText, markerText, '', '')
		endif
		return foldText
	endfunction
endif

" turn on folding, remove the fold column, use the syntax method, use my
" function to generate the fold text, and make the fill character a space
setlocal foldenable
setlocal foldcolumn=0
setlocal foldmethod=marker
setlocal foldtext=VimFoldText()
setlocal fillchars=fold:\ 
"}}}


"==============================================================================
" the comment/uncomment plugin {{{
"==============================================================================
if !exists('*Comment') || !exists('*Uncomment')
	echoerr 'Command() or Uncomment() is undefined. Do you have plugin/codeTools.vim loaded?'
else
	" create the command mappings to call the functions
	if !exists('no_plugin_maps') && !exists('no_vim_maps')
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


" restore the original cpoptions
let &cpo = s:save_cpo

