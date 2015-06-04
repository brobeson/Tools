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
		if return_type != 'explicit' && return_type != 'void' && return_type != ''
			if return_type == 'bool'
				call add(a:comment, s:line_start . 'retval  true')
				call add(a:comment, s:line_start . 'retval  false')
			else
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
" code folding {{{
"==============================================================================
" \brief	Determine the fold text for a doxygen comment block.
" \details	The fold text should present the brief command text as a comment:
"				/** this is some brief description of the class */
"				/*! so is this */
"			If no brief desctiption can be found, the words 'no brief
"			description' is used.
" \returns  A string to be used as the fold text.
" \retval   '' indicates that this folding block is not a doxygen comment.
if !exists('*FoldDoxygen')
	function FoldDoxygen()
		" assume this isn't a doxygen comment
		let fold_text = ''

		" get the first line. we need it to determine what type of fold text
		" to create.
		let first_line = getline(v:foldstart)

		" doxygen comment blocks
		if match(first_line, '^\s*\/\*[!\*]') == 0
			" put a space between /** and the brief text. also, remove any
			" text after the /**.
			let fold_text = substitute(first_line, '\(\/\*[!\*]\).*', '\1 ', '')

			let comments = getline(v:foldstart, v:foldend)

			" remove leading *s and white space from subsequent lines in
			" the comments. note that we can't use
			" 'for comment in comments' here; the assignment in the loop
			" would assign to a copy, not the actual list item.
			for i in range(1, len(comments) - 1)
				let comments[i] = substitute(comments[i], '^\s*\*\?\s*', '', '')
			endfor

			" locate the brief text in the comment. the brief text goes from
			" '@brief' (or '\brief') until the next '@' (or '\').  get all
			" the lines in the block comment, then find the line which
			" contains the 'brief' tag.
			let brief_start = match(comments, '[@|\\]brief')

			" if the brief tag was found...
			if 0 <= brief_start
				" find the end of the brief description. this occurs when:
				" 1 - the next doxygen command is found,
				" 2 - a blank line occurs after the brief text
				" then crop the comments array, so we only have the brief text
				let comments = comments[brief_start : match(comments, '\([@|\\]\|^\s*$\)', brief_start + 1) - 1]

				" from the first brief line, remove everything except the
				" actual text: ' * @brief blah' becomes 'blah'
				let comments[0] = substitute(comments[0], '^.*[@\\]brief\s*', '', '')

			" if a brief command wasn't found, it's possible for a javadoc
			" style comment to use the first sentence as the brief comment.
			elseif match(first_line, '^\s*\/\*\*') == 0
				let brief_start = match(comments, '\w.*')
				if 0 <= brief_start
					" this match is a bit tricky. the javadoc autobrief ends
					" with the first period followed by a space or newline.
					" Since we're searching an array, there are no newline
					" characters.
					let comments = comments[brief_start : match(comments, '\.\s\?', brief_start)]
				endif
			endif

			" if we found a brief, use that as the fold text, otherwise state
			" that no fold text was found.
			if 0 <= brief_start
				let fold_text .= join(comments) . ' */'
			else
				let fold_text .= 'no brief description */'
			endif
		endif

		return fold_text
	endfunction
endif
"}}}


" restore the original cpoptions
let &cpo = s:save_cpo

