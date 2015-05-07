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
iabbrev make-target $@
iabbrev make-archive $%
iabbrev make-first-prereq $<
iabbrev make-newer-prereqs $?
iabbrev make-prereqs $^
iabbrev make-all-prereqs $+
iabbrev make-target-stem $*
" }}}

" restore the original cpoptions
let &cpo = s:save_cpo

