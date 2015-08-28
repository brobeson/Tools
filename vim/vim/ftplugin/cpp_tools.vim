" Vim plugin to add a bunch of functionality related to C++ development.
" Last Change:	2015 March 8
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)
" License:		Public Domain
"
"  - add functionality to insert Doxygen comments
"  - add my code folding text and fold settings
"  - add functionality to comment and uncomment a range of lines
"  - add functionality to create a new class declaration
"  - add functionality to yank lines of code, and paste them as a new function

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_cpp')
	finish
endif
let b:loaded_cpp = 1

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
		noremap  <buffer> <unique> <script> <Plug>CppComment :call Comment('//')<CR>

		" map the uncomment command
		if !hasmapto('<Plug>CppUncomment')
			map <buffer> <unique> <Leader>u <Plug>CppUncomment
		endif
		noremap  <buffer> <unique> <script> <Plug>CppUncomment :call Uncomment('//')<CR>
	endif
endif
"}}}


"==============================================================================
" the new class plugin {{{
"==============================================================================
if !exists('no_plugin_maps') && !exists('no_cpp_maps')
	" map the new class command
	if !hasmapto('<Plug>CppNewClass')
		map <buffer> <unique> <Leader>p <Plug>CppNewClass
	endif
	noremap  <buffer> <unique> <script> <Plug>CppNewClass :call <SID>NewClass()<CR>
endif

" define the function to create a new class
if !exists('*s:NewClass')
	function s:NewClass()
		let start_line = line('.')

		" ask the user for a class name. the default is the file name, sans
		" path and extension.
		let class_name = substitute(expand('%:t'), '\.' . expand('%:e') . '$', '', '')
		let class_name = input('enter a name for the class: ', class_name)
		echo class_name

		" build up the class declaration
		let class_declaration = []
		call add(class_declaration, 'class ' . class_name)
		call add(class_declaration, '{')
		call add(class_declaration, 'public:')
		call add(class_declaration, '~' . class_name . '() noexcept = default;')
		call add(class_declaration, '')
		call add(class_declaration, class_name . '() = delete;')
		call add(class_declaration, class_name . '(' . class_name . '&) = delete;')
		call add(class_declaration, class_name . '(' . class_name . '&&) = delete;')
		call add(class_declaration, class_name . '& operator=(' . class_name . '&) = delete;')
		call add(class_declaration, class_name . '& operator=(' . class_name . '&&) = delete;')
		call add(class_declaration, '')
		call add(class_declaration, 'private:')
		call add(class_declaration, '};')

		" add it to the buffer and reformat it
		call append(line('.'), class_declaration)
		execute 'normal' len(class_declaration) + 1 . '=='

		" and add doxygen comments
		"call <SID>InsertDoxygen()
		if exists(':Doxygenate')
			call cursor(start_line + 6, 1)
			Doxygenate
			call cursor(start_line + 4, 1)
			Doxygenate
			execute 'normal A      Destroy a ' . class_name . ' object.'
			call cursor(start_line + 1, 1)
			Doxygenate
		endif
	endfunction
endif
"}}}


"==============================================================================
" the extract-to-function plugin {{{
"==============================================================================
if !exists('no_plugin_maps') && !exists('no_cpp_maps')
	" map the delete command
	if !hasmapto('<Plug>CppDeleteFunction')
		map <buffer> <unique> <Leader>fd <Plug>CppDeleteFunction
	endif
	noremap  <buffer> <unique> <script> <Plug>CppDeleteFunction :call <SID>DeleteFunction()<CR>

	" map the paste below command
	if !hasmapto('<Plug>CppPasteFunction')
		map <buffer> <unique> <Leader>fp <Plug>CppPasteFunction
	endif
	noremap  <buffer> <unique> <script> <Plug>CppPasteFunction :call <SID>PasteFunction()<CR>
endif

" this is script scope so the lines can be deleted from one file, and pasted
" to a new function in another file.
let s:functionBody = []

" define the function to paste a buffer as a function
if !exists('*s:PasteFunction')
	function s:PasteFunction()
		call append(line('.'), s:functionBody)
		let lineCount = len(s:functionBody)

		" reformat the code
		normal j
		execute 'normal' lineCount . '=='

		" add two lines after the function
		execute 'normal' lineCount - 1 . 'jo'
		normal o

		" return to the top of the function
		execute 'normal' lineCount  + 1. 'k'

		" and add doxygen comments
		call <SID>InsertDoxygen()
	endfunction
endif

" define the function to uncomment a range of lines
if !exists('*s:DeleteFunction')
	function s:DeleteFunction() range
		" prompt the user for the function declaration
		call inputsave()
		let declaration = input('enter the function declaration: ')

		" if the user add a semicolon, a compiler error will result, so chuck
		" it.
		let declaration = substitute(declaration, ';$', '', '')

		" get the lines to be cut
		let lineRange = a:lastline - a:firstline + 1
		let s:functionBody = getline(a:firstline, a:lastline)
		execute 'normal ' . lineRange . 'dd'

		" prepend the function declaration and opening brace, then append the
		" closing brace
		call insert(s:functionBody, '{')
		call insert(s:functionBody, declaration)
		call add(s:functionBody, '}')

		" get the replacement function call, then append it
		let functionCall = substitute(declaration, '\S*\s', '', '')
		let functionCall = substitute(functionCall, '(.*$', '(', '')
		let functionCall = input('enter the call to the new function: ', functionCall)
		normal k
		call append(line('.'), functionCall)
		normal j==

		"echo lineRange 'lines deleted, ready to be put as a function'
		call inputrestore()
	endfunction
endif
"}}}


"==============================================================================
"command -buffer Define :call s:DefineMethod()
"if !exists('*s:DefineMethod')
"	function s:DefineMethod()
"		" extract the whole header
"		let functionDeclaration = []
"		let lastLine = search(';', 'cnW')
"		let currentLine = line('.')
"		while currentLine <= lastLine
"			call insert(functionDeclaration, getline(currentLine))
"			let currentLine = currentLine + 1
"		endwhile

"		" open the source file and append the declaration
"		let sourceFile = substitute(expand('%:p'), 'hpp$', 'cpp', '')
"		execute 'tabnew' sourceFile
"		normal G
"		let pasteLine = line('.')
"		call add(functionDeclaration, '{')
"		call add(functionDeclaration, '}')
"		call append(pasteLine, functionDeclaration)
"		"call cursor(pasteLine, 1)
"		"execute 'normal ' . line('G') - pasteLine . '=='
"	endfunction
"endif

" restore the original cpoptions
let &cpo = s:save_cpo

