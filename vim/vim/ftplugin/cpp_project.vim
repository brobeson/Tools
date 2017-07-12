" Vim file type plug-in for establishing a C++ project.
" Last Change: 2017 July 11
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
"                                                               establish some script-wide variables
"--------------------------------------------------------------------------------------------------
let s:build_type = 'unset'


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
let s:project_name = strcharpart(path, strchars(g:cpp_project_prefix) + 1)
let s:project_name = matchstr(s:project_name, '[^\/]\+\/')
let s:project_name = strcharpart(s:project_name, 0, strchars(s:project_name) - 1)

" establish the root directory for the project. it's the prefix directory followed by the project
" name
let s:project_directory = g:cpp_project_prefix . '/' . s:project_name

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

    let s:build_type = a:build_type
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
    " determine the modification time of the tags files
    let t = getftime(s:project_release_directory . '/tags')
    if t < 0
        let release_tags_time = "doesn't exist"
    else
        let release_tags_time = strftime("%Y %B %d %X", t)
    endif
    let t = getftime(s:project_debug_directory . '/tags')
    if t < 0
        let debug_tags_time = "doesn't exist"
    else
        let debug_tags_time = strftime("%Y %B %d %X", t)
    endif

    " print the basic project information
    echo 'project'
    echo '    name           ' . s:project_name
    echo '    directory      ' . s:project_directory
    echo '    source         ' . s:source_directory
    echo '    current build  ' . s:build_type

    " print information related to a release build
    echo 'release build'
    echo '    directory      ' . s:project_release_directory
    echo '    tags file      ' . s:project_release_directory . '/tags'
    echo '    tags generated ' . release_tags_time

    " print information related to a debug build
    echo 'debug build'
    echo '    directory      ' . s:project_debug_directory
    echo '    tags file      ' . s:project_debug_directory . '/tags'
    echo '    tags generated ' . debug_tags_time
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

" default to a debug build
BuildDebug


"--------------------------------------------------------------------------------------------------
"                                                               clean up after the script
"--------------------------------------------------------------------------------------------------
let &cpo = s:save_cpo
unlet s:save_cpo
