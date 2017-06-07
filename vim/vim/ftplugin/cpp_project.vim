"----------------------------------------------------------------------------------------------
"                                                             establish the projects directory
"----------------------------------------------------------------------------------------------
" if the user did not define a prefix directory, default to the home directory. look in the home
" directory for a set of common possibilities for a directory which contains C++ projects.
if !exists('g:cpp_project_prefix')
    let prefix = $HOME
    let possible_subdirectories = [ '/repositories',
                                \   '/projects',
                                \   '/source',
                                \   '/src' ]
    for subdirectory in possible_subdirectories
        if isdirectory(prefix . subdirectory)
            let prefix .= subdirectory
        endif
    endfor

    " if none of the possibilities panned out, issue a warning
    if prefix == $HOME
        echoerr 'g:cpp_project_prefix was not set, and the guesses do not exist.'
        echomsg 'cpp_project functions will not be available.'
        echomsg 'Set g:cpp_project_prefix to enable cpp_project.'
        finish
    endif

    let g:cpp_project_prefix = prefix
    echo g:cpp_project_prefix
endif

