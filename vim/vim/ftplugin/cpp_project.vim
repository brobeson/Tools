"--------------------------------------------------------------------------------------------------
"                                                               establish the projects directory
"--------------------------------------------------------------------------------------------------
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
endif


"--------------------------------------------------------------------------------------------------
"                                                               attempt to determine this project's
"                                                               directory
"--------------------------------------------------------------------------------------------------
" get the full path to the opened file, without the file name
let path = simplify(getcwd() . '/' . expand('%:h'))

" determine if the path is within the prefix
if stridx(path, g:cpp_project_prefix) != 0
    finish
endif

" establish the name of the project. remove the prefix, then drop everything including and after the
" first '/'
let project_name = strcharpart(path, strchars(g:cpp_project_prefix) + 1)
let project_name = matchstr(project_name, '[^\/]\+\/')
let project_name = strcharpart(project_name, 0, strchars(project_name) - 1)

"echo project_name

" establish the root directory for the project. it's the prefix directory followed by the project
" name
let project_directory = g:cpp_project_prefix . '/' . project_name

"--------------------------------------------------------------------------------------------------
"                                                               check for a debug & release
"                                                               directory
"--------------------------------------------------------------------------------------------------
let project_debug_directory   = project_directory . '/debug'
let project_release_directory = project_directory . '/release'

" if the debug or release directories don't exist, create them
if finddir('debug', project_directory) == ""
    call mkdir(project_debug_directory)
endif
if finddir('release', project_directory) == ""
    call mkdir(project_release_directory)
endif

