" Vim plugin to manipulate Doxygen comments for C++ source code.
" Last Change:	2015 June 2
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)
" License:		Public Domain

" check if this plugin (or one with the same name) has already been loaded
"if exists('b:loaded_cpp_doxygen')
"	finish
"endif
let b:loaded_cpp_doxygen = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim

"==============================================================================
" set the configuration variables {{{
"==============================================================================
" set the default comment block style. available options are:
"	javadoc			/** ... */
"	qt				/*! ... */
"	triple_slash	///
"	exclamation		//!
if !exists('g:cpp_doxygen_block_style')
	let g:cpp_doxygen_block_style = 'javadoc'
endif

" set the default command mark, either a '\' or '@' character.
if !exists('g:cpp_doxygen_command_mark')
	let g:cpp_doxygen_command_mark = '\'
endif

" remember the block style set by the user. this uses a double variable
" mechanism. the user sets g:cpp_doxygen_block_style. when a command is
" executed, the command should check if g:cpp_doxygen_block_style is the same
" as s:block_style. if they're different, the user has changed the block style
" and the script needs to run VerifyConfig() (detailed below) to set all the
" script-local variables.
let s:block_style = ''

" \brief	Set up script-local variables based on the global block style.
"if !exists('*s:VerifyConfig')
	function! s:VerifyConfig()
		" verify the block style
		if s:block_style != g:cpp_doxygen_block_style
			if g:cpp_doxygen_block_style == 'qt'
				let s:block_open = '/*!'
				let s:block_continue = ' * '
				let s:block_close = ' */'
			elseif g:cpp_doxygen_block_style == 'triple_slash'
				let s:block_open = ''
				let s:block_continue = '/// '
				let s:block_close = ''
			elseif g:cpp_doxygen_block_style == 'exclamation'
				let s:block_open = ''
				let s:block_continue = '//! '
				let s:block_close = ''
			else
				let s:block_open = '/**'
				let s:block_continue = ' * '
				let s:block_close = ' */'
			endif
			let s:block_style = g:cpp_doxygen_block_style
		endif

		" make sure the command mark is correct. only \ and @ are allowed. If
		" it's not @, just set the default: \. Also, use a local variable,
		" mrk, for brevity in the code later.
		if g:cpp_doxygen_command_mark != '@' && g:cpp_doxygen_command_mark != '\'
			let g:cpp_doxygen_command_mark = '\'
		endif

		" set the characters which start a line in the comment block. this
		" makes the code more straight forward later.
		let s:line_start = s:block_continue . g:cpp_doxygen_command_mark
	endfunction
"endif
" }}}


"==============================================================================
" create a command to insert doxygen comments {{{
"==============================================================================
" map the doxygen comment command
if !exists('b:loaded_cpp_doxygen')
if !exists('no_plugin_maps') && !exists('no_cpp_maps')
	if !hasmapto('<Plug>cpp_doxygenInsert')
		map <buffer> <unique> <Leader>d <Plug>cpp_doxygenInsert
	endif
	noremap  <buffer> <unique> <script> <Plug>cpp_doxygenInsert :call <SID>InsertDoxygen()<CR>
endif
endif


" \brief	This function adds the file level Doxygen block.
if !exists('*s:InsertFileDoxygen')
	function s:InsertFileDoxygen()
		let fileHeader = [ s:line_start . 'file     ' . expand('%:t'),
						 \ s:line_start . 'brief',
						 \ s:line_start . 'details',
						 \ s:line_start . 'author' ]
		if g:cpp_doxygen_block_style == 'javadoc' || g:cpp_doxygen_block_style == 'qt'
			call insert(fileHeader, s:block_open)
			call add(fileHeader, s:block_close)
		endif
		call append(0, fileHeader)
		call cursor(3, strlen(getline(3)))
	endfunction
endif


" \brief	This function adds \cond and \endcond around deleted functions.
if !exists('*s:InsertDeletedDoxygen')
	function s:InsertDeletedDoxygen()
		" note that this is hard coded to use /** ... */ block style.
		" doxygen's manual states that /// and //! require at least two
		" lines, but these are one line each, so...
		execute ':normal! O'  . s:block_open . ' ' . g:cpp_doxygen_command_mark . 'cond' . s:block_close
		execute ':normal! 2j'

		" loop over subsequent statements. all consecutive deleted functions
		" are wrapped in one set of condition commands.
		let done = 0
		while done == 0
			if match(join(getline('.', search('[;{]', 'cnW'))), 'delete') != -1
				execute ':normal j'
			else
				let done = 1
			endif
		endwhile
		execute ':normal! O' . s:block_open . ' ' . g:cpp_doxygen_command_mark . 'endcond' . s:block_close
	endfunction
endif


" \brief	This function begins creating the doxygen comment block.
" \details	It intializes the comment with commands common to all the blocks.
"           This function does not apply to the file comment, or to deleted
"           functions.
"if !exists('*s:CreateDoxygenComment')
	function! s:CreateDoxygenComment()
		" add the lines which are common to all the doxygen comments
		let comment =	[ s:line_start . 'brief',
						\ s:line_start . 'details' ]
		if g:cpp_doxygen_block_style == 'javadoc' || g:cpp_doxygen_block_style == 'qt'
			call insert(comment, s:block_open)
		endif
		return comment
	endfunction
"endif


" \brief	Insert a doxygen comment block.
"if !exists('*s:InsertDoxygen')
	function! s:InsertDoxygen()
		" verify the configuration. anything incorrect should be corrected
		" after this.
		call s:VerifyConfig()

		" if the cursor is on the first line, insert the file documentation
		if line('.') == 1
			call s:InsertFileDoxygen()

		" if the cursor is not on the first line, the user is attempting to
		" document a code statement.
		else
			" extract the whole statement
			let cursorStartLine = line('.')
			let text = join(getline('.', search('[;{]', 'cnW')))

			" look for deleted functions
			if match(text, 'delete') != -1
				call s:InsertDeletedDoxygen()

			" if this code block is not a deleted function
			else
				let comment = s:CreateDoxygenComment()

			"	" check if this is a template class or function. if it is,
			"	" add the tparam tags.
			"	let hasTemplate = match(text, 'template')
			"	if hasTemplate != -1
			"		let start = stridx(text, '<') + 1
			"		let end = stridx(text, '>', start)
			"		let templateParameters = strpart(text, start, end - start)
			"		let templateParameters = substitute(templateParameters, '\(<\|,\|>\)', '', 'g')
			"		let paramList = split(templateParameters)
			"		let index = 1
			"		while index < len(paramList)
			"			call add(comment, s:block_continue . mrk . 'tparam	' . paramList[index])
			"			let index = index + 2
			"		endwhile
			"	endif
			"	" done checking for template parameters

			"	" check if this is a function. it will have ()s.
			"	let isFunction = match(text, '(')
			"	if (isFunction != -1)
			"		let start = stridx(text, '(') + 1
			"		let end = stridx(text, ')', start)
			"		let parameters = strpart(text, start, end - start)
			"		let parameterList = split(parameters, ',')
			"		let index = 0
			"		while index < len(parameterList)
			"			let paramText = '' . mrk . 'param'
			"			let paramName = matchstr(parameterList[index], '\w\+$')

			"			" the rules for determining if a parameter is in or out:
			"			" 1 - if const appears first, it is input only
			"			" 2 - if it's a reference or a constant pointer, it is input &
			"			"     output
			"			" 3 - otherwise it is input only
			"			" to really know whether something is output only, one needs
			"			" to examine the function code, which is beyond the scope of
			"			" this plugin, so we default to [in,out] instead of [out].
			"			if match(parameterList[index], '^\s*const') != -1
			"				let paramText .= '[in]	'
			"			elseif match(parameterList[index], '\(&\s*[a-zA-Z0-9_]$\|\*\s*const\|const\s*\*\)') != -1
			"				let paramText .= '[in,out]	'
			"			else
			"				let paramText .= '[in]	'
			"			endif

			"			call add(comment, s:block_continue . paramText . paramName)
			"			let index = index + 1
			"		endwhile

			"		" figure out the return type, at this point isFunction holds the
			"		" location of the opening (
			"		let returnType = substitute(text, '\s\+\(\w\+\|operator.*\)(.*', '', '')
			"		let returnType = matchstr(returnType, '[a-zA-Z0-9_<>]\+$')
			"		if returnType == 'bool'
			"			call add(comment, s:block_continue . mrk . 'retval	true')
			"			call add(comment, s:block_continue . mrk . 'retval	false')
			"		elseif returnType != 'void' && returnType != ''
			"			call add(comment, s:block_continue . mrk . 'return')
			"		endif

			"		" tack on a report about if the function throws any exceptions
			"		if match(text, 'noexcept') != -1
			"			call add(comment, s:block_continue . mrk . 'exception	None')
			"		else
			"			call add(comment, s:block_continue . mrk . 'exception')
			"		endif
			"	endif

				" close the comment
				if g:cpp_doxygen_block_style == 'javadoc' || g:cpp_doxygen_block_style == 'qt'
					call add(comment, s:block_close)
				endif

				" add the comment to the buffer, and format it
				call append(line('.') - 1, comment)
				call cursor(cursorStartLine, 1)
				execute 'normal' len(comment) . '=='

			"	" move the cursor to the end of the brief tag.
			"	normal j$
			endif
		endif
	endfunction
"endif
"}}}


"==============================================================================
"" code folding {{{
""==============================================================================
"" adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
"" and another that I accidentally erased. i'm not sure why, but i can't make
"" this a script local function. if i do, then use 'set foldtext=<SID>CppFoldText',
"" then the folding doesn't display correctly.
"if !exists('*CppFoldText')
"	function CppFoldText()
"		" get the first line. we need it to determine what type of fold text
"		" to create. also initialize the fold text in a way to indicate a
"		" folding case I haven't handled.
"		let firstLine = getline(v:foldstart)
"		let foldText = 'NO FOLD TEXT DEFINED'

"		" 'commented' code via #if 0, or #ifdef 0
"		if match(firstLine, '^\s*#if\(def\)\?\s*0') == 0
"			let codeLine = getline(v:foldstart + 1)
"			let spaceCount = match(codeLine, '\S')
"			let foldText = repeat(' ', spaceCount) . '[ commented code ]  '
"			let foldText .= substitute(codeLine, '^\s*', '', '')

"		" javadoc comment blocks
"		elseif match(firstLine, '^\s*\/\*') == 0
"			" i want this fold text to show the brief part of the comment:
"			" /** this is some brief description of the class */

"			" put a space between /** and the brief text
"			let foldText = substitute(firstLine, '\/\*\*.*', '\/\*\* ', '')

"			" locate the brief text in the comment. the brief text goes from
"			" '@brief' (or '\brief') until the next '@' (or '\').  get all
"			" the lines in the block comment, then find the line which
"			" contains the 'brief' tag.
"			let comments   = getline(v:foldstart, v:foldend)
"			let briefStart = match(comments, '[@|\\]brief')
"			let groupStart = match(comments, '[a|\\]\(addto\|def\|in\|weak\)group')

"			" if the brief tag was found...
"			if 0 < briefStart
"				" find the next javadoc tag, which marks the end of the brief
"				" text. then crop the comments array.
"				let briefEnd = match(comments, '[@|\\]', briefStart + 1) - 1
"				let comments = comments[briefStart : briefEnd]

"				" from the first brief line, remove everything except the
"				" actual text: ' * @brief blah' becomes 'blah'
"				let comments[0] = substitute(comments[0], '^\s*\*\s*[@\\]brief\s*', '', '')

"				" remove leading *s from subsequent lines in the brief text
"				let index = 1
"				while index < len(comments)
"					let comments[index] = substitute(comments[index], '^\s*\*\?\s*', '', '')
"					let index           = index + 1
"				endwhile

"				" finally, combine all the lines into the fold's fill text
"				let commentString = join(comments)
"				if 0 < strlen(commentString)
"					let foldText .= commentString . ' */'
"				else
"					let foldText .= 'no brief description */'
"				endif

"			" if there is no brief tag, but there is a grouping tag
"			"elseif 0 < groupStart
"			"	let foldText = comments
"			"endif

"			" if there is no brief tag, set the fill text to indicate that
"			else
"				let foldText .= 'no brief description */'
"			endif

"		" code blocks
"		else
"			" remove text following the block's opening '{'. it's not just set
"			" to a brace, because we want to keep the leading white space so
"			" the fold text remains aligned with the block identifier
"			" (function name, class name, etc).
"			let foldText = substitute(firstLine, '{.*', '{', '')

"			" the fill text is the number of folded lines, right justified
"			let foldText .= printf(' %5d lines }', v:foldend - v:foldstart + 1)
"		endif

"		" vim sets the tab character to 1 space in the fold text.  I want
"		" the braces to remain aligned as in the code, so swap out the
"		" tabs for enough spaces to match the tabstop
"		let spaces = repeat(' ', &tabstop)
"		let foldText = substitute(foldText, '\t', spaces, 'g')
"		return foldText
"	endfunction
"endif

"" turn on folding, remove the fold column, use the syntax method, use my
"" function to generate the fold text, and make the fill character a space
"setlocal foldenable
"setlocal foldcolumn=0
"setlocal foldmethod=syntax
"setlocal foldtext=CppFoldText()
"setlocal fillchars=fold:\ 
""}}}


" restore the original cpoptions
let &cpo = s:save_cpo

