" Vim plugin to add a bunch of functionality related to C++ development.
" Last Change:	2015 January 02
" Maintainer:  Brendan Robeson (ogslanger@vt.edu)
" License:     Public Domain
"
"  - add mappings for common editing modes, such as inserting text before a ;
"  - add functionality to insert Doxygen comments
"  - add my code folding text and fold settings
"  - add functionality to comment and uncomment a range of lines
"  - add functionality to yank lines of code, and paste them as a new function

" check if this plugin (or one with the same name) has already been loaded
if exists("b:loaded_cpp")
	finish
endif
let b:loaded_cpp = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim

set cursorline

"==============================================================================
" map some normal mode keystrokes to common C++ editing operations {{{
"==============================================================================
" move to the end and erase a character
nmap <buffer> <Leader>x $x

" enter insert mode right before the last character, typically a ; or )
nmap <buffer> <Leader>i $i

" enter 'replace' mode at the last character. I frequently encounter a
" situation where I need to remove the last character then append new text.
" you may be wondering why I don't map to $R.  I tried that and felt that $xa
" provides better feedback by just removing the last character.
nmap <buffer> <Leader>r $xa
"}}}


"==============================================================================
" create a command to insert doxygen comments {{{
"==============================================================================
 map the doxygen comment command
if !exists("no_plugin_maps") && !exists("no_cpp_maps")
	if !hasmapto('<Plug>Cpp_Doxygen')
		map <buffer> <unique> <Leader>d <Plug>Cpp_Doxygen
	endif
	noremap  <buffer> <unique> <script> <Plug>Cpp_Doxygen <SID>InsertDoxygen
	noremap  <buffer>                   <SID>InsertDoxygen     :call <SID>InsertDoxygen()<CR>
endif
noremenu <script> &C++.Insert\ &Doxygen <SID>InsertDoxygen

" insert the doxygen comment
if !exists("*s:InsertDoxygen")
	function s:InsertDoxygen()
		" extract the whole header
		let lastLine = search("[;{]", "cnW")
		let currentLine = line(".")
		let cursorLeaveLine = currentLine + 1
		let text = ""
		while currentLine <= lastLine
			let text .= getline(currentLine)
			let currentLine = currentLine + 1
		endwhile

		" look for deleted functions
		if match(text, "delete") != -1
			execute ":normal! O/** @cond */"
			execute ":normal! jo/** @endcond */"

		" if this code block is not a deleted function
		else
			execute ":normal! O/**\n@brief\n@details"

			" check if this is a template class or function. if it is,
			" add the tparam tags.
			let hasTemplate = match(text, "template")
			if hasTemplate != -1
				let start = stridx(text, "<") + 1
				let end = stridx(text, ">", start)
				let templateParameters = strpart(text, start, end - start)
				let templateParameters = substitute(templateParameters, '\(<\|,\|>\)', '', 'g')
				let paramList = split(templateParameters)
				let index = 1
				while index < len(paramList)
					execute ":normal! o@tparam\t" . paramList[index]
					let index = index + 2
				endwhile
			endif
			" done checking for template parameters

			" check if this is a function. it will have ()s.
			let isFunction = match(text, "(")
			if (isFunction != -1)
				let start = stridx(text, "(") + 1
				let end = stridx(text, ")", start)
				let parameters = strpart(text, start, end - start)
				let parameterList = split(parameters, ',')
				let index = 0
				while index < len(parameterList)
					let paramText = "@param"
					let paramName = matchstr(parameterList[index], '\w\+$')

					" the rules for determining if a parameter is in or out:
					" 1 - if const appears first, it is input only
					" 2 - if it's a reference or a constant pointer, it is input &
					"     output
					" 3 - otherwise it is input only
					" to really know whether something is output only, one needs
					" to examine the function code, which is beyond the scope of
					" this plugin, so we default to [in,out] instead of [out].
					if match(parameterList[index], '^\s*const') != -1
						let paramText .= "[in]\t"
					elseif match(parameterList[index], '\(&\s*[a-zA-Z0-9_]$\|\*\s*const\|const\s*\*\)') != -1
						let paramText .= "[in,out]\t"
					else
						let paramText .= "[in]\t"
					endif

					execute ":normal! o" . paramText . paramName
					let index = index + 1
				endwhile

				" figure out the return type, at this point isFunction holds the
				" location of the opening (
				let returnType = substitute(text, '\s\+\(\w\+\|operator.*\)(.*', '', '')
				let returnType = matchstr(returnType, '[a-zA-Z0-9_<>]\+$')
				if returnType == "bool"
					execute ":normal! o@retval\ttrue\n@retval\tfalse"
				elseif returnType != "void" && returnType != ""
					execute ":normal! o@return"
				endif

				" tack on a report about if the function throws any exceptions
				if match(text, "noexcept") != -1
					execute ":normal! o@exception\tNone"
				else
					execute ":normal! o@exception"
				endif
			endif

			execute ":normal! o/"
		endif
		call cursor(cursorLeaveLine, 1)
	endfunction
endif
"}}}


"==============================================================================
" code folding {{{
"==============================================================================
" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" and another that I accidentally erased. i'm not sure why, but i can't make
" this a script local function. if i do, then use 'set foldtext=<SID>CppFoldText',
" then the folding doesn't display correctly.
if !exists("*CppFoldText")
	function CppFoldText()
		" get the first line. we need it to determine what type of fold text
		" to create. also initialize the fold text in a way to indicate a
		" folding case I haven't handled.
		let firstLine = getline(v:foldstart)
		let foldText = 'NO FOLD TEXT DEFINED'

		" 'commented' code via #if 0, or #ifdef 0
		if match(firstLine, '^\s*#if\(def\)\?\s*0') == 0
			let codeLine = getline(v:foldstart + 1)
			let spaceCount = match(codeLine, '\S')
			let foldText = repeat(' ', spaceCount) . "[ commented code ]  "
			let foldText .= substitute(codeLine, '^\s*', '', '')

		" javadoc comment blocks
		elseif match(firstLine, '^\s*\/\*') == 0
			" i want this fold text to show the brief part of the comment:
			" /** this is some brief description of the class */

			" put a space between /** and the brief text
			let foldText = substitute(firstLine, '\/\*\*.*', '\/\*\* ', '')

			" locate the brief text in the comment. the brief text goes from
			" '@brief' (or '\brief') until the next '@' (or '\').  get all
			" the lines in the block comment, then find the line which
			" contains the 'brief' tag.
			let comments   = getline(v:foldstart, v:foldend)
			let briefStart = match(comments, '[@|\\]brief')
			let groupStart = match(comments, '[a|\\]\(addto\|def\|in\|weak\)group')

			" if the brief tag was found...
			if 0 < briefStart
				" find the next javadoc tag, which marks the end of the brief
				" text. then get crop the comments array.
				let briefEnd = match(comments, '[@|\\]', briefStart + 1) - 1
				let comments = comments[briefStart : briefEnd]

				" from the first brief line, remove everything except the
				" actual text: ' * @brief blah' becomes 'blah'
				let comments[0] = substitute(comments[0], '^\s*\*\s*[@\\]brief\s*', '', '')

				" remove leading *s from subsequent lines in the brief text
				let index = 1
				while index < len(comments)
					let comments[index] = substitute(comments[index], '^\s*\*\?\s*', '', '')
					let index           = index + 1
				endwhile

				" finally, combine all the lines into the fold's fill text
				let foldText .= join(comments) . ' */'

"			" if there is no brief tag, but there is a grouping tag
"			elseif 0 < groupStart
"				let foldText = comments
"			endif

			" if there is no brief tag, set the fill text to indicate that
			else
				let foldText .= 'no brief description */'
			endif

		" code blocks
		else
			" remove text following the block's opening '{'. it's not just set
			" to a brace, because we want to keep the leading white space so
			" the fold text remains aligned with the block identifier
			" (function name, class name, etc).
			let foldText = substitute(firstLine, '{.*', '{', '')

			" the fill text is the number of folded lines, right justified
			let foldText .= printf(" %5d lines }", v:foldend - v:foldstart + 1)
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
" load the general comment & uncomment functions
runtime comment.vim

" create the command mappings to call the functions
if !exists("no_plugin_maps") && !exists("no_cpp_maps")
	" map the comment command
	if !hasmapto('<Plug>CppComment')
		map <buffer> <unique> <Leader>c <Plug>CppComment
	endif
	noremap  <buffer> <unique> <script> <Plug>CppComment <SID>Comment
	noremap  <buffer>                   <SID>Comment     :call Comment("//")<CR>

	" map the uncomment command
	if !hasmapto('<Plug>CppUncomment')
		map <buffer> <unique> <Leader>u <Plug>CppUncomment
	endif
	noremap  <buffer> <unique> <script> <Plug>CppUncomment <SID>Uncomment
	noremap  <buffer>                   <SID>Uncomment     :call Uncomment("//")<CR>
endif
noremenu <script> &C++.&Comment   <SID>Comment
noremenu <script> &C++.&Uncomment <SID>Uncomment
"}}}


"==============================================================================
" the extract-to-function plugin {{{
"==============================================================================
if !exists("no_plugin_maps") && !exists("no_cpp_maps")
	" map the delete command
	if !hasmapto('<Plug>CppDeleteFunction')
		map <buffer> <unique> <Leader>fd <Plug>CppDeleteFunction
	endif
	noremap  <buffer> <unique> <script> <Plug>CppDeleteFunction <SID>DeleteFunction
	noremap  <buffer>                   <SID>DeleteFunction     :call <SID>DeleteFunction()<CR>

	" map the paste below command
	if !hasmapto('<Plug>CppPasteFunctionBelow')
		map <buffer> <unique> <Leader>fp <Plug>CppPasteFunctionBelow
	endif
	noremap  <buffer> <unique> <script> <Plug>CppPasteFunctionBelow <SID>PasteFunctionBelow
	noremap  <buffer>                   <SID>PasteFunctionBelow     :call <SID>PasteFunction('below')<CR>

	" map the paste above command
	if !hasmapto('<Plug>CppPasteFunctionAbove')
		map <buffer> <unique> <Leader>fP <Plug>CppPasteFunctionAbove
	endif
	noremap  <buffer> <unique> <script> <Plug>CppPasteFunctionAbove <SID>PasteFunctionAbove
	noremap  <buffer>                   <SID>PasteFunctionAbove     :call <SID>PasteFunction('above')<CR>
endif
noremenu <script> &C++.&Delete\ for\ Function	<SID>DeleteFunction
noremenu <script> &C++.&Paste\ as\ Function		<SID>PasteFunctionAbove

let s:functionBody = []

" define the function to paste a buffer as a function
if !exists("*s:PasteFunction")
	function s:PasteFunction(aboveOrBelow)
		if a:aboveOrBelow == 'above'
			normal k
		endif
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
if !exists("*s:DeleteFunction")
	function s:DeleteFunction() range
		" prompt the user for the function declaration
		call inputsave()
		let declaration = input("enter the function declaration: ")

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
		let functionCall = input("enter the call to the new function: ", functionCall)
		normal k
		call append(line('.'), functionCall)
		normal j==

		"echo lineRange "lines deleted, ready to be put as a function"
		call inputrestore()
	endfunction
endif
"}}}


" restore the original cpoptions
let &cpo = s:save_cpo

