" Vim plugin to comment & uncomment a range of lines of code
" Last Change:	2015 January 02
" Maintainer:	Brendan Robeson (github.com/brobeson/Tools/)
" License:		Public Domain
"
" I know other scripts to do this exist, particularly the NERDcommenter.
" That's just much more than I need. Also, I used this an exercise in learning
" to write Vim scripts.
"
" Obviously, you can call these functions directly. However, the intention is
" to create command mappings in an ftplugin to call these. See my cpp.vim for
" an example.
"
" For both functions, the argument 'commentString' is the string of characters
" which create a single line comment. For example, for C++, you'd want to pass
" in '//', for Vim you'd pass in '"'.

" check if this plugin (or one with the same name) has already been loaded
if exists("g:loaded_comment")
	finish
endif
let g:loaded_comment = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim

" define the function to comment a range of lines
if !exists("*Comment")
	function Comment(commentString) range
		" determine the smallest column at which text begins the lines in the
		" range. use the first non-blank line to get the initial column.
		let commentColumn = 0
		let lineNumber = nextnonblank(a:firstline)
		if lineNumber <= a:lastline
			call cursor(lineNumber, 0)
			normal ^
			let commentColumn = col('.')
		endif

		" now loop through the remaining lines. any non-blank line with text
		" further left than has already been found, sets a new column for the
		" comment marker.
		while lineNumber <= a:lastline
			let lineNumber = nextnonblank(lineNumber + 1)
			if (lineNumber <= a:lastline)
				call cursor(lineNumber, 0)
				normal ^
				if col('.') < commentColumn
					let commentColumn = col('.')
				endif
			endif
		endwhile

		" now go back through the lines, inserting the comment characters at
		" that minimum column.
		let lineNumber = nextnonblank(a:firstline)
		while lineNumber <= a:lastline
			call cursor(lineNumber, commentColumn)
			execute 'normal i' . a:commentString
			let lineNumber = nextnonblank(lineNumber + 1)
		endwhile

		" tell the user how many lines were commented
		call cursor(a:firstline, commentColumn)
		echo a:lastline - a:firstline + 1 "lines commented"
	endfunction
endif

" define the function to uncomment a range of lines
if !exists("*Uncomment")
	function Uncomment(commentString) range
		" this is the cleanest way i found to uncomment the
		" lines without incurring problems if folding is enabled.
		for line in range(a:firstline, a:lastline)
			"call setline(line, substitute(getline(line), '\/\/', '', ''))
			call setline(line, substitute(getline(line), a:commentString, '', ''))
		endfor
		normal ^
		echo a:lastline - a:firstline + 1 "lines uncommented"
	endfunction
endif

" restore the original cpoptions
let &cpo = s:save_cpo

