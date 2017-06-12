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
let s:project_directory = g:cpp_project_prefix . '/' . project_name

" establish the root source directory for the project.
let s:source_directory = strcharpart(path, strchars(s:project_directory) + 1)
let s:source_directory = matchstr(s:source_directory, '[^\/]\+\/')
let s:source_directory = strcharpart(s:source_directory, 0, strchars(s:source_directory) - 1)
let s:source_directory = s:project_directory . '/' . s:source_directory


"--------------------------------------------------------------------------------------------------
"                                                               check for a debug & release
"                                                               directory
"--------------------------------------------------------------------------------------------------
let s:project_debug_directory   = s:project_directory . '/debug'
let s:project_release_directory = s:project_directory . '/release'

" if the debug or release directories don't exist, create them
if finddir('debug', s:project_directory) == ""
    call mkdir(s:project_debug_directory)
endif
if finddir('release', s:project_directory) == ""
    call mkdir(s:project_release_directory)
endif


"--------------------------------------------------------------------------------------------------
"                                                               function to set debug or release
"                                                               build
"--------------------------------------------------------------------------------------------------
if !exists('*s:cpp_project_set_build_type')
    function s:cpp_project_set_build_type(build_type)
        " verify the value of build_type input. this must be either 'debug' or 'release'
        if a:build_type != 'release' && a:build_type != 'debug'
            echoerr 'cannot set a build type of ' . a:build_type
            echo    'possible values for build type are "release" or "debug"'
            return
        endif

        " get the number of processors, and subtract 1. this is the number of processors to use for
        " parallel building.
        let processor_count = system('nproc') - 1

        " determine the directory in which to build
        if a:build_type == 'release'
            let g:current_build_directory = s:project_release_directory
        else
            let g:current_build_directory = s:project_debug_directory
        endif

        " set the makeprg variable. this is done using :let instead of :set, so that variables are
        " expanded to generate the makeprg string.
        let &makeprg = 'make --jobs=' . processor_count . ' --directory=' . g:current_build_directory

        " set the file for which to generate ctags.
        let &tags = g:current_build_directory . '/tags'
    endfunction
endif


"--------------------------------------------------------------------------------------------------
"                                                               function to regenerate C tags
"--------------------------------------------------------------------------------------------------
if !exists('*s:cpp_project_regenerate_tags')
    function s:cpp_project_regenerate_tags()
        if !exists('g:current_build_directory')
            echoerr 'current build type has not been defined'
            echo    'run the command :BuildDebug or :BuildRelease'
            return
        endif

        call system('ctags -f ' . &tags . ' -R ' . s:source_directory)
    endfunction
endif


"--------------------------------------------------------------------------------------------------
"                                                               commands to invoke the proper
"                                                               functionality
"--------------------------------------------------------------------------------------------------
" switch to a debug build
if !exists(':BuildDebug')
    command -buffer BuildDebug :call s:cpp_project_set_build_type('debug')
endif

" switch to a release build
if !exists(':BuildRelease')
    command -buffer BuildRelease :call s:cpp_project_set_build_type('release')
endif

" regenerate C tags
if !exists(':Retag')
    command -buffer Retag :call s:cpp_project_regenerate_tags()
endif
