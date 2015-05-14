" Vim plugin to add a bunch of functionality related to make file development
" Last Change:	2015 May 6
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)
" License:		Public Domain
"
"  - add functionality to comment and uncomment a range of lines
"  - TODO	add code folding text
"  - add replacements for some automatic variables

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_make')
	finish
endif
let b:loaded_make = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim


"==============================================================================
" code folding {{{
"==============================================================================
" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. i'm not sure why, but i can't make
" this a script local function. if i do, then using
" set foldtext=<SID>MakeFoldText, then the folding doesn't display correctly.
if !exists('*MakeFoldText')
	function MakeFoldText()
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
		let foldText .= substitute(firstLine, '^\s*#\s*', '', '')
		let markerText = substitute(&foldmarker, ',.*', '', '')
		let foldText = substitute(foldText, markerText, '', '')
		return foldText
	endfunction
endif

" turn on folding, remove the fold column, use the syntax method, use my
" function to generate the fold text, and make the fill character a space
setlocal foldenable
setlocal foldcolumn=0
setlocal foldmethod=marker
setlocal foldtext=MakeFoldText()
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


"==============================================================================
" auto replacement of make automatic variables {{{
"==============================================================================
iabbrev make_target $@
iabbrev make_archive $%
iabbrev make_first_prereq $<
iabbrev make_newer_prereqs $?
iabbrev make_prereqs $^
iabbrev make_all_prereqs $+
iabbrev make_target_stem $*
" }}}

" restore the original cpoptions
let &cpo = s:save_cpo

