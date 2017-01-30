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

" highlight cmake variables used in configure_file() input
syntax match cppCmakeVariable /${\i\+}/
highlight default link cppCmakeVariable identifier

" load syntax highlighting for APIs and libraries
runtime! syntax/stl.vim
runtime! syntax/opengl.vim
runtime syntax/doxygen.vim " only grab my doxygen.vim... not the system version
syntax cluster cCommentGroup add=doxCommand
