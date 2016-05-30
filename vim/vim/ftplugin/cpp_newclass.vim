" Vim plug-in to stub in a new C++ class.
" Last Change:  2016 May 29
" Maintainer:   Brendan Robeson (github.com/brobeson/Tools.git)

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_cpp_newclass')
    finish
endif
let b:loaded_cpp_newclass = 1

" map the new class command
if !hasmapto('<Plug>CppNewClass')
    map <buffer> <unique> <Leader>p <Plug>CppNewClass
endif
noremap  <buffer> <unique> <script> <Plug>CppNewClass :call <SID>NewClass()<CR>

if !exists('s:cpp_new_class_declaration')
    let s:cpp_new_class_declaration = [
                \ 'class class_name final',
                \ '{',
                \ 'public:',
                \ 'class_name() = default;',
                \ '',
                \ 'class_name(const class_name&) = default;',
                \ '',
                \ 'class_name(class_name&&) = default;',
                \ '',
                \ '~class_name() noexcept = default;',
                \ '',
                \ 'class_name& operator=(const class_name&) = default;',
                \ '',
                \ 'class_name& operator=(class_name&&) = default;',
                \ '',
                \ 'private:',
                \ '};' ]
    let s:cpp_new_class_declaration_length = len(s:cpp_new_class_declaration) + 1
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
        for line in s:cpp_new_class_declaration
            call add(class_declaration, substitute(line, 'class_name', class_name, 'g'))
        endfor

        " add it to the buffer and reformat it
        call append(line('.'), class_declaration)
        execute 'silent normal' s:cpp_new_class_declaration_length . "=="

        " and add doxygen comments
        "call <SID>InsertDoxygen()
        "if exists(':Doxygenate')
        "   call cursor(start_line + 6, 1)
        "   Doxygenate
        "   call cursor(start_line + 4, 1)
        "   Doxygenate
        "   execute 'normal A      Destroy a ' . class_name . ' object.'
        "   call cursor(start_line + 1, 1)
        "   Doxygenate
        "endif
    endfunction
endif

