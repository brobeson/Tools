" Vim file type plug-in for establishing a C++ project.
" Last Change: 2017 June 28
" Maintainer:  brobeson <https://github.com/brobeson/tools>
" License:     MIT license
"
" todo
" 1.    add a menu items to invoke the commands
" 2.    which global variables can be made script-local?

"--------------------------------------------------------------------------------------------------
"                                                               set up for proper execution of the
"                                                               script
"--------------------------------------------------------------------------------------------------
if exists('g:loaded_cpp_project')
    finish
endif
let g:loaded_cpp_project = 1

" store the cpoptions so non-compatible script will work
let s:save_cpo = &cpo
set cpo&vim


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
function s:set_build_type(build_type)
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


"--------------------------------------------------------------------------------------------------
"                                                               function to regenerate C tags
"--------------------------------------------------------------------------------------------------
function s:regenerate_tags()
    if !exists('g:current_build_directory')
        echoerr 'current build type has not been defined'
        echo    'run the command :BuildDebug or :BuildRelease'
        return
    endif

    call system('ctags -f ' . &tags . ' -R ' . s:source_directory)
endfunction


"--------------------------------------------------------------------------------------------------
"                                                               function to list build information
"--------------------------------------------------------------------------------------------------
function s:build_information()
    echo 'project directory........ ' . s:project_directory
    echo 'source directory......... ' . s:source_directory
    echo 'release build directory.. ' . s:project_release_directory
    echo 'debug build directory.... ' . s:project_debug_directory
    "echo '-----------------------------------------------------------------------------------'
    if exists('g:current_build_directory')
        echo 'current build directory.. ' . g:current_build_directory
    else
        echo 'no build type selected'
    endif
endfunction


"--------------------------------------------------------------------------------------------------
"                                                               commands and menu options to invoke
"                                                               the proper functionality
"--------------------------------------------------------------------------------------------------
" commands to switch to debug build, switch to release build, and to regenerate tags
command BuildDebug :call s:set_build_type('debug')
command BuildInformation :call s:build_information()
command BuildRelease :call s:set_build_type('release')
command Retag :call s:regenerate_tags()


"--------------------------------------------------------------------------------------------------
"                                                               clean up after the script
"--------------------------------------------------------------------------------------------------
let &cpo = s:save_cpo
unlet s:save_cpo
