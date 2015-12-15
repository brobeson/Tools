" C++ developers should be using nullptr instead of NULL
syntax keyword cppError NULL
highlight default link cppError Error

" highlight gcc's __PRETTY_FUNCTION__
syntax keyword cppPrettyFunc __PRETTY_FUNCTION__
highlight default link cppPrettyFunc Macro

" override some highlight linking
highlight! default link cStructure   Statement
highlight! default link cppStructure Statement

" match Doxygen 'todo' comments
syntax match doxyTodo contained /[\\@]\ctodo/
syntax cluster cCommentGroup add=doxyTodo
highlight default link doxyTodo Todo

" load STL syntax highlighting
if !exists('cpp_no_stl')
	runtime! syntax/stl.vim
endif

" load OpenGL syntax highlighting
runtime! syntax/opengl.vim

" highlight cmake variables used in configure_file() input
syntax match cppCmakeVariable /${\i\+}/
highlight default link cppCmakeVariable identifier
