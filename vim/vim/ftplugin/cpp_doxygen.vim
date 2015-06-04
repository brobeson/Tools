" Vim plugin to manipulate Doxygen comments for C++ source code.
" Last Change:	2015 June 2
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools.git)
" License:		Public Domain

" check if this plugin (or one with the same name) has already been loaded
if exists('b:loaded_cpp_doxygen')
	finish
endif
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
if !exists('*s:VerifyConfig')
	function s:VerifyConfig()
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
endif
" }}}


"==============================================================================
" create a command to insert doxygen comments {{{
"==============================================================================
" map the doxygen comment command
if !exists('no_plugin_maps') && !exists('no_cpp_maps')
	if !hasmapto('<Plug>cpp_doxygenInsert')
		map <buffer> <unique> <Leader>d <Plug>cpp_doxygenInsert
	endif
	noremap  <buffer> <unique> <script> <Plug>cpp_doxygenInsert :call <SID>InsertDoxygen()<CR>
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
if !exists('*s:CreateDoxygenComment')
	function s:CreateDoxygenComment()
		" add the lines which are common to all the doxygen comments
		let comment =	[ s:line_start . 'brief',
						\ s:line_start . 'details' ]
		if g:cpp_doxygen_block_style == 'javadoc' || g:cpp_doxygen_block_style == 'qt'
			call insert(comment, s:block_open)
		endif
		return comment
	endfunction
endif


" \brief	Add tparam commands to the doxygen comment.
" \details	The template parameter names are also added.
if !exists('*s:AddTemplateParameters')
	function s:AddTemplateParameters(comment, statement)
		let start = stridx(a:statement, '<') + 1
		let end = stridx(a:statement, '>', start)
		let templateParameters = strpart(a:statement, start, end - start)
		let templateParameters = substitute(templateParameters, '\(<\|,\|>\)', '', 'g')
		let paramList = split(templateParameters)
		let index = 1
		while index < len(paramList)
			call add(a:comment, s:line_start . 'tparam  ' . paramList[index])
			let index = index + 2
		endwhile
	endfunction
endif


if !exists('*s:AddFunction')
	function s:AddFunction(comment, statement)
		" start with the list of parameters. find the '(' and ')' in the
		" statement. extract the text between them and split it into a list of
		" parameters. then we can examine each parameter for constness,
		" reference, etc. to determine if it's [in] or [in,out], and also
		" extract the parameter name.
		let param_cmd     = s:line_start . 'param'
		let param_start   = stridx(a:statement, '(') + 1
		let param_end     = stridx(a:statement, ')', param_start)
		for parameter in split(strpart(a:statement, param_start, param_end - param_start), ',')
			let param_name = matchstr(parameter, '\w\+$')

			" the rules for determining if a parameter is in or out:
			" 1 - if it's a reference or a constant pointer, it is input &
			"     output
			" 2 - otherwise it is input only
			" to really know whether something is output only, one needs
			" to examine the function code, which is beyond the scope of
			" this plugin, so we default to [in,out] instead of [out].
			if match(parameter, '\(&\s*[a-zA-Z0-9_]$\|\*\s*const\|const\s*\*\)') != -1
				call add(a:comment, param_cmd . '[in,out]  ' . param_name)
			else
				call add(a:comment, param_cmd . '[in]  ' . param_name)
			endif
		endfor

		" figure out the return type.
		let return_type = substitute(a:statement, '\s\+\(\w\+\|operator.*\)(.*', '', '')
		let return_type = matchstr(return_type, '[a-zA-Z0-9_<>]\+$')
		if return_type != 'explicit'
			if return_type == 'bool'
				call add(a:comment, s:line_start . 'retval  true')
				call add(a:comment, s:line_start . 'retval  false')
			elseif return_type != 'void' && return_type != ''
				call add(a:comment, s:line_start . 'return')
			endif
		endif

		" tack on a report about any exceptions
		if match(a:statement, 'noexcept') != -1
			call add(a:comment, s:line_start . 'exception  None')
		else
			call add(a:comment, s:line_start . 'exception')
		endif
	endfunction
endif


" \brief	Insert a doxygen comment block.
if !exists('*s:InsertDoxygen')
	function s:InsertDoxygen()
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
			let statement = join(getline('.', search('[;{]', 'cnW')))
			let statement = substitute(statement, '\s\+', ' ', 'g')

			" look for deleted functions
			if match(statement, 'delete') != -1
				call s:InsertDeletedDoxygen()

			" if this code block is not a deleted function
			else
				let comment = s:CreateDoxygenComment()

				" handle any template parameters
				if match(statement, 'template') != -1
					call s:AddTemplateParameters(comment, statement)
				endif

				" handle a function
				if match(statement, '(') != -1
					call s:AddFunction(comment, statement)
				endif

				" close the comment
				if g:cpp_doxygen_block_style == 'javadoc' || g:cpp_doxygen_block_style == 'qt'
					call add(comment, s:block_close)
				endif

				" add the comment to the buffer, format it, and move the
				" cursor to the end of the brief command.
				call append(line('.') - 1, comment)
				call cursor(cursorStartLine, 1)
				execute 'normal' len(comment) . '=='
				normal j$
				startinsert!
			endif
		endif
	endfunction
endif
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

