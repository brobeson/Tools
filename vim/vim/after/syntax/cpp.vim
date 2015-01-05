" C++ developers should be using nullptr instead of NULL
syntax keyword cppError NULL
highlight default link cppError Error

" match Doxygen 'todo' comments
syntax match doxyTodo contained /[\\@]\ctodo/
syntax cluster cCommentGroup add=doxyTodo
highlight default link doxyTodo Todo

" load STL syntax highlighting
"if !exists("cpp_no_stl")
"	runtime! syntax/stl.vim
"endif

