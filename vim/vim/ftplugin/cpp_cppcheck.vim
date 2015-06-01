" Vim plugin to run Cppcheck on the current buffer.
" Last Change:	2015 May 29
" Maintainer:	Brendan Robeson (https://github.com/brobeson/Tools)
" License:		Public Domain

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_cpp_cppcheck')
	finish
endif
let b:loaded_cpp_cppcheck = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim


" ensure that the options and path variables have been defined. if the
" user hasn't done so, set them up with defaults
if !exists('g:cpp_cppcheck_options')
	let g:cpp_cppcheck_options = ''
endif

" set up the command and function to set the Cppcheck output template. setting
" this is done in this manner because we really need two format strings: one
" for Cppcheck and a second for Vim. Having the user set 1 format should
" eliminate errors; let the computer generate the other format to match.
if !exists(':SetCppcheckTemplate')
	command -buffer -nargs=1 SetCppcheckTemplate :call s:SetCppcheckTemplate(<args>)
endif

if !exists('*s:SetCppcheckTemplate')
	function s:SetCppcheckTemplate(newTemplate)
		" 1. remove the old vim pattern from the errorformat option
		" 2. set the new cppcheck template
		" 3. convert the new cppcheck template to a vim errorformat pattern
		" 4. append the new vim pattern to the errorformat option
		if s:cpp_check_vim_format != ''
			execute 'setlocal efm-=' . s:cpp_check_vim_format
		endif
		let s:cpp_check_error_format = a:newTemplate

		" special handling for gcc and vs. these are keywords cppcheck accepts
		" for the template.
		if s:cpp_check_error_format == 'gcc'
			let s:cpp_check_vim_format = '%f:%l:%m'
		elseif s:cpp_check_error_format == 'vs'
			let s:cpp_check_vim_format = '%f(%l):%m'
		else
			" first, replase backslashes, commas, and percents. these have
			" special meaning in the vim errorformat, so if the user wants
			" them in the cppcheck template, we need to handle them correctly.
			let s:cpp_check_vim_format = substitute(s:cpp_check_error_format, '\', '\\\\', 'g')
			let s:cpp_check_vim_format = substitute(s:cpp_check_vim_format,   ',', '\\,',  'g')
			let s:cpp_check_vim_format = substitute(s:cpp_check_vim_format,   '%', '%%',   'g')

			" now replace the cppcheck template tags with vim errorformat tags
			" TODO	{callstack}, {id}, and {severity}
			let s:cpp_check_vim_format = substitute(s:cpp_check_vim_format, '{file}',    '%f', 'g')
			let s:cpp_check_vim_format = substitute(s:cpp_check_vim_format, '{line}',    '%l', 'g')
			let s:cpp_check_vim_format = substitute(s:cpp_check_vim_format, '{message}', '%m', 'g')
		endif

		execute 'setlocal efm+=' . s:cpp_check_vim_format
	endfunction
endif

" set the default error format to gcc.
let s:cpp_check_error_format = ''
let s:cpp_check_vim_format = ''
call s:SetCppcheckTemplate('gcc')

" create the command to run Cppcheck
if !exists(':Cppcheck')
	command -buffer Cppcheck :call s:RunCppcheck()
endif

" the function to do the work
if !exists('*s:RunCppcheck')
	function s:RunCppcheck()
		if executable('cppcheck') == 0
			echo 'Cppcheck cannot be found. Ensure the path to cppcheck is in your PATH environment variable.'
		else
			let cmd = 'silent !cppcheck --template=' . s:cpp_check_error_format . ' ' . g:cpp_cppcheck_options . ' ' . expand('%:p') . ' 2> ' . &errorfile
			execute cmd
			cgetfile
			copen
		endif
	endfunction
endif


" restore the original cpoptions
let &cpo = s:save_cpo
unlet s:save_cpo

