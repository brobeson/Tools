" Vim syntax file
" Program:      CMake - Cross-Platform Makefile Generator
" Language:     CMake
" Author:       Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:  2019 March 21

if exists("b:current_syntax")
   finish
endif
let s:keepcpo= &cpo
set cpo&vim

" comments {{{
syntax case ignore
syntax keyword cmakeTodo BUG FIXME HACK TODO XXX contained
syntax region cmakeComment start="#" end="$" contains=@Spell,cmakeTodo
syntax case match
" }}}

" an argument list for commands. most everything in CMake needs to be in the
" argument list
syntax region cmakeArgumentList start=/(/ end=/)/ transparent fold
      \ contains=ALL,@Spell,cmakeCommand,cmakeDeprecated,cmakeFormat,ctestCommand

" strings, and format specifiers for string(TIMESTAMP ...)
syntax region cmakeString start=/"/ skip=/\\"/ end=/"/ contained
      \ contains=cmakeFloat,cmakeFormat,cmakeInteger,cmakeRegistry,cmakeVariableReference,cmakeVersion
syntax match cmakeFormat "%[dHIjmMSUwyY]" contained

" numbers {{{
syntax match cmakeInteger /\<\d\+/ contained
syntax match cmakeFloat /\<\d\+\.\d*/ contained
syntax match cmakeVersion /\<\d\+\(.\d\+\)\{2,3}/ contained
syntax region cmakeRegistry start=/\[/ end=/]/ contained oneline
" }}}

" variables {{{
syntax keyword cmakeType BOOL FILEPATH INTERNAL PATH STATIC STRING UNINITIALIZED contained

syntax region cmakeVariableReference start=/$\(ENV\|CACHE\)\?{/ end=/}/ oneline contained
syntax region cmakeVariableReference start=/@/ end=/@/ oneline

" these are the variables built in to CMake.

" variables with <PackageName> in them
syntax match cmakeVariable /CMAKE_DISABLE_FIND_PACKAGE_\i\+/ contained

" variable with <PROJECT-NAME> in them
syntax match cmakeVariable /CMAKE_PROJECT_\i\+_INCLUDE/ contained
syntax match cmakeVariable
      \ /\i\+_\(BINARY_DIR\|SOURCE-DIR\|VERSION\(_MAJOR\|_MINOR\|_PATCH\|_TWEAK\)\?\)/
      \ contained

" variables with policy numbers
syntax match cmakeVariable /CMAKE_POLICY_\(DEFAULT|WARNING\)_CMP\d\d\d\d/ contained

" XCode attributes
syntax match cmakeVariable /CMAKE_XCODE_ATTRIBUTE_\i\+/ contained

" variables with <LANG> in them
syntax match cmakeVariable /CMAKE_\i\+_\(ARCHIVE_\(APPEND\|CREATE\|FINISH\)\)/ contained
syntax match cmakeVariable /CMAKE_\i\+_CLANG_TIDY/ contained
syntax match cmakeVariable /CMAKE_\i\+_COMPILE_OBJECT/ contained
syntax match cmakeVariable /CMAKE_\i\+_COMPILER\(_\(ABI\|ARCHITECTURE_ID\|EXTERNAL_TOOLCHAIN\|ID\|LAUNCHER\|LOADED\|TARGET\|VERSION\)\)\?/ contained
syntax match cmakeVariable /CMAKE_\i\+_CPPCHECK/ contained
syntax match cmakeVariable /CMAKE_\i\+_CREATE_\(SHARED_\(LIBRARY\|MODULE\)\|STATIC_LIBRARY\)/ contained
syntax match cmakeVariable /CMAKE_\i\+_FLAGS\(_DEBUG\|_MINSIZEREL\|_RELEASE\|_RELWITHDEBINFO\)\?/ contained
syntax match cmakeVariable /CMAKE_\i\+_IGNORE_EXTENSIONS/ contained
syntax match cmakeVariable /CMAKE_\i\+_IMPLICIT_\(INCLUDE_DIRECTORIES\|LINK_\(DIRECTORIES\|FRAMEWORK_DIRECTORIES\|LIBRARIES\)\)/ contained
syntax match cmakeVariable /CMAKE_\i\+_LIBRARY_ARCHITECTURE/ contained
syntax match cmakeVariable /CMAKE_\i\+_LINKER_PREFERENCE\(_PROPAGATES\)\?/ contained
syntax match cmakeVariable /CMAKE_\i\+_LINK_EXECUTABLE/ contained
syntax match cmakeVariable /CMAKE_\i\+_OUTPUT_EXTENSION/ contained
syntax match cmakeVariable /CMAKE_\i\+_PLATFORM_ID/ contained
syntax match cmakeVariable /CMAKE_\i\+_SIMULATE_\(ID\|VERSION\)/ contained
syntax match cmakeVariable /CMAKE_\i\+_SIZEOF_DATA_PTR/ contained
syntax match cmakeVariable /CMAKE_\i\+_SOURCE_FILE_EXTENSIONS/ contained
syntax match cmakeVariable /CMAKE_\i\+_VISIBILITY_PRESET/ contained
syntax match cmakeVariable /CMAKE_USER_MAKE_RULES_\i\+/ contained

" all others
syntax keyword cmakeVariable APPLE
      \ BORLAND
      \ BUILD_SHARED_LIBS
      \ CMAKE_ABSOLUTE_DESTINATION_FILES
      \ CMAKE_ANDROID_API
      \ CMAKE_ANDROID_API_MIN
      \ CMAKE_ANDROID_GUI
      \ CMAKE_APPBUNDLE_PATH
      \ CMAKE_AR
      \ CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      \ CMAKE_ARGC
      \ CMAKE_ARGV0
      \ CMAKE_AUTOMOC
      \ CMAKE_AUTOMOC_MOC_OPTIONS
      \ CMAKE_AUTOMOC_RELAXED_MODE
      \ CMAKE_AUTORCC
      \ CMAKE_AUTORCC_OPTIONS
      \ CMAKE_AUTOUIC
      \ CMAKE_AUTOUIC_OPTIONS
      \ CMAKE_BACKWARDS_COMPATIBILITY
      \ CMAKE_BINARY_DIR
      \ CMAKE_BUILD_TOOL
      \ CMAKE_BUILD_TYPE
      \ CMAKE_BUILD_WITH_INSTALL_RPATH
      \ CMAKE_CACHEFILE_DIR
      \ CMAKE_CACHE_MAJOR_VERSION
      \ CMAKE_CACHE_MINOR_VERSION
      \ CMAKE_CACHE_PATCH_VERSION
      \ CMAKE_C_COMPILE_FEATURES
      \ CMAKE_C_EXTENSIONS
      \ CMAKE_CFG_INTDIR
      \ CMAKE_CL_64
      \ CMAKE_COLOR_MAKEFILE
      \ CMAKE_COMMAND
      \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY
      \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_DEBUG
      \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_MINSIZERELEASE
      \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_RELEASE
      \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO
      \ CMAKE_COMPILER_2005
      \ CMAKE_COMPILER_IS_GNUCC
      \ CMAKE_COMPILER_IS_GNUCXX
      \ CMAKE_COMPILER_IS_GNUG77
      \ CMAKE_DEBUG_POSTFIX
      \ CMAKE_MINSIZERELEASE_POSTFIX
      \ CMAKE_RELEASE_POSTFIX
      \ CMAKE_RELWITHDEBINFO_POSTFIX
      \ CMAKE_CONFIGURATION_TYPES
      \ CMAKE_CROSSCOMPILING
      \ CMAKE_C_STANDARD
      \ CMAKE_C_STANDARD_REQUIRED
      \ CMAKE_CTEST_COMMAND
      \ CMAKE_CURRENT_BINARY_DIR
      \ CMAKE_CURRENT_LIST_DIR
      \ CMAKE_CURRENT_LIST_FILE
      \ CMAKE_CURRENT_LIST_LINE
      \ CMAKE_CURRENT_SOURCE_DIR
      \ CMAKE_CXX_COMPILE_FEATURES
      \ CMAKE_CXX_EXTENSIONS
      \ CMAKE_CXX_STANDARD
      \ CMAKE_CXX_STANDARD_REQUIRED
      \ CMAKE_DEBUG_POSTFIX
      \ CMAKE_DEBUG_TARGET_PROPERTIES
      \ CMAKE_DL_LIBS
      \ CMAKE_EDIT_COMMAND
      \ CMAKE_ERROR_DEPRECATED
      \ CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION
      \ CMAKE_EXECUTABLE_SUFFIX
      \ CMAKE_EXE_LINKER_FLAGS
      \ CMAKE_EXE_LINKER_FLAGS_DEBUG
      \ CMAKE_EXE_LINKER_FLAGS_MINSIZERELEASE
      \ CMAKE_EXE_LINKER_FLAGS_RELEASE
      \ CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO
      \ CMAKE_EXPORT_NO_PACKAGE_REGISTRY
      \ CMAKE_EXTRA_GENERATOR
      \ CMAKE_EXTRA_SHARED_LIBRARY_SUFFIXES
      \ CMAKE_FIND_LIBRARY_PREFIXES
      \ CMAKE_FIND_LIBRARY_SUFFIXES
      \ CMAKE_FIND_NO_INSTALL_PREFIX
      \ CMAKE_FIND_PACKAGE_NAME
      \ CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY
      \ CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY
      \ CMAKE_FIND_PACKAGE_WARN_NO_MODULE
      \ CMAKE_FIND_ROOT_PATH
      \ CMAKE_FIND_ROOT_PATH_MODE_INCLUDE
      \ CMAKE_FIND_ROOT_PATH_MODE_LIBRARY
      \ CMAKE_FIND_ROOT_PATH_MODE_PACKAGE
      \ CMAKE_FIND_ROOT_PATH_MODE_PROGRAM
      \ CMAKE_Fortran_FORMAT
      \ CMAKE_Fortran_MODDIR_DEFAULT
      \ CMAKE_Fortran_MODDIR_FLAG
      \ CMAKE_Fortran_MODOUT_FLAG
      \ CMAKE_Fortran_MODULE_DIRECTORY
      \ CMAKE_FRAMEWORK_PATH
      \ CMAKE_GENERATOR
      \ CMAKE_GENERATOR_PLATFORM
      \ CMAKE_GENERATOR_TOOLSET
      \ CMAKE_GNUtoMS
      \ CMAKE_HOME_DIRECTORY
      \ CMAKE_HOST_APPLE
      \ CMAKE_HOST_SYSTEM
      \ CMAKE_HOST_SYSTEM_NAME
      \ CMAKE_HOST_SYSTEM_PROCESSOR
      \ CMAKE_HOST_SYSTEM_VERSION
      \ CMAKE_HOST_UNIX
      \ CMAKE_HOST_WIN32
      \ CMAKE_IGNORE_PATH
      \ CMAKE_IMPORT_LIBRARY_PREFIX
      \ CMAKE_IMPORT_LIBRARY_SUFFIX
      \ CMAKE_INCLUDE_CURRENT_DIR
      \ CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE
      \ CMAKE_INCLUDE_DIRECTORIES_BEFORE
      \ CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE
      \ CMAKE_INCLUDE_PATH
      \ CMAKE_INSTALL_DEFAULT_COMPONENT_NAME
      \ CMAKE_INSTALL_MESSAGE
      \ CMAKE_INSTALL_NAME_DIR
      \ CMAKE_INSTALL_PREFIX
      \ CMAKE_INSTALL_RPATH
      \ CMAKE_INSTALL_RPATH_USE_LINK_PATH
      \ CMAKE_INTERNAL_PLATFORM_ABI
      \ CMAKE_JOB_POOL_COMPILE
      \ CMAKE_JOB_POOL_LINK
      \ CMAKE_LIBRARY_ARCHITECTURE
      \ CMAKE_LIBRARY_ARCHITECTURE_REGEX
      \ CMAKE_LIBRARY_OUTPUT_DIRECTORY
      \ CMAKE_LIBRARY_PATH
      \ CMAKE_LIBRARY_PATH_FLAG
      \ CMAKE_LINK_DEF_FILE_FLAG
      \ CMAKE_LINK_DEPENDS_NO_SHARED
      \ CMAKE_LINK_INTERFACE_LIBRARIES
      \ CMAKE_LINK_LIBRARY_FILE_FLAG
      \ CMAKE_LINK_LIBRARY_FLAG
      \ CMAKE_LINK_LIBRARY_SUFFIX
      \ CMAKE_MACOSX_BUNDLE
      \ CMAKE_MACOSX_RPATH
      \ CMAKE_MAJOR_VERSION
      \ CMAKE_MAKE_PROGRAM
      \ CMAKE_MAP_IMPORTED_CONFIG_DEBUG
      \ CMAKE_MAP_IMPORTED_CONFIG_MINSIZERELEASE
      \ CMAKE_MAP_IMPORTED_CONFIG_RELEASE
      \ CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO
      \ CMAKE_MATCH_COUNT
      \ CMAKE_MFC_FLAG
      \ CMAKE_MINIMUM_REQUIRED_VERSION
      \ CMAKE_MINOR_VERSION
      \ CMAKE_MODULE_LINKER_FLAGS
      \ CMAKE_MODULE_LINKER_FLAGS_DEBUG
      \ CMAKE_MODULE_LINKER_FLAGS_MINSIZERELEASE
      \ CMAKE_MODULE_LINKER_FLAGS_RELEASE
      \ CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO
      \ CMAKE_MODULE_PATH
      \ CMAKE_NO_BUILTIN_CHRPATH
      \ CMAKE_NO_SYSTEM_FROM_IMPORTED
      \ CMAKE_NOT_USING_CONFIG_FLAGS
      \ CMAKE_OBJECT_PATH_MAX
      \ CMAKE_OSX_ARCHITECTURES
      \ CMAKE_OSX_DEPLOYMENT_TARGET
      \ CMAKE_OSX_SYSROOT
      \ CMAKE_PARENT_LIST_FILE
      \ CMAKE_PATCH_VERSION
      \ CMAKE_PDB_OUTPUT_DIRECTORY
      \ CMAKE_PDB_OUTPUT_DIRECTORY_DEBUG
      \ CMAKE_PDB_OUTPUT_DIRECTORY_MINSIZERELEASE
      \ CMAKE_PDB_OUTPUT_DIRECTORY_RELEASE
      \ CMAKE_PDB_OUTPUT_DIRECTORY_RELWITHDEBINFO
      \ CMAKE_POSITION_INDEPENDENT_CODE
      \ CMAKE_PREFIX_PATH
      \ CMAKE_PROGRAM_PATH
      \ CMAKE_PROJECT_NAME
      \ CMAKE_RANLIB
      \ CMAKE_ROOT
      \ CMAKE_RUNTIME_OUTPUT_DIRECTORY
      \ CMAKE_SCRIPT_MODE_FILE
      \ CMAKE_SHARED_LIBRARY_PREFIX
      \ CMAKE_SHARED_LIBRARY_SUFFIX
      \ CMAKE_SHARED_LINKER_FLAGS
      \ CMAKE_SHARED_LINKER_FLAGS_DEBUG
      \ CMAKE_SHARED_LINKER_FLAGS_MINSIZERELEASE
      \ CMAKE_SHARED_LINKER_FLAGS_RELEASE
      \ CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO
      \ CMAKE_SHARED_MODULE_PREFIX
      \ CMAKE_SHARED_MODULE_SUFFIX
      \ CMAKE_SIZEOF_VOID_P
      \ CMAKE_SKIP_BUILD_RPATH
      \ CMAKE_SKIP_INSTALL_ALL_DEPENDENCY
      \ CMAKE_SKIP_INSTALL_RPATH
      \ CMAKE_SKIP_INSTALL_RULES
      \ CMAKE_SKIP_RPATH
      \ CMAKE_SOURCE_DIR
      \ CMAKE_STAGING_PREFIX
      \ CMAKE_STANDARD_LIBRARIES
      \ CMAKE_STATIC_LIBRARY_PREFIX
      \ CMAKE_STATIC_LIBRARY_SUFFIX
      \ CMAKE_STATIC_LINKER_FLAGS
      \ CMAKE_STATIC_LINKER_FLAGS_DEBUG
      \ CMAKE_STATIC_LINKER_FLAGS_MINSIZERELEASE
      \ CMAKE_STATIC_LINKER_FLAGS_RELEASE
      \ CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO
      \ CMAKE_SYSROOT
      \ CMAKE_SYSTEM
      \ CMAKE_SYSTEM_IGNORE_PATH
      \ CMAKE_SYSTEM_INCLUDE_PATH
      \ CMAKE_SYSTEM_LIBRARY_PATH
      \ CMAKE_SYSTEM_NAME
      \ CMAKE_SYSTEM_PREFIX_PATH
      \ CMAKE_SYSTEM_PROCESSOR
      \ CMAKE_SYSTEM_PROGRAM_PATH
      \ CMAKE_SYSTEM_VERSION
      \ CMAKE_TOOLCHAIN_FILE
      \ CMAKE_TRY_COMPILE_CONFIGURATION
      \ CMAKE_TWEAK_VERSION
      \ CMAKE_USE_RELATIVE_PATHS
      \ CMAKE_USER_MAKE_RULES_OVERRIDE
      \ CMAKE_VERBOSE_MAKEFILE
      \ CMAKE_VERSION
      \ CMAKE_VISIBILITY_INLINES_HIDDEN
      \ CMAKE_VS_DEVENV_COMMAND
      \ CMAKE_VS_INTEL_Fortran_PROJECT_VERSION
      \ CMAKE_VS_MSBUILD_COMMAND
      \ CMAKE_VS_MSDEV_COMMAND
      \ CMAKE_VS_NsightTegra_VERSION
      \ CMAKE_VS_PLATFORM_NAME
      \ CMAKE_VS_PLATFORM_TOOLSET
      \ CMAKE_WARN_DEPRECATED
      \ CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION
      \ CMAKE_WIN32_EXECUTABLE
      \ CMAKE_XCODE_PLATFORM_TOOLSET
      \ CPACK_ABSOLUTE_DESTINATION_FILES
      \ CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY
      \ CPACK_DEBIAN_FILE_NAME
      \ CPACK_DEBIAN_PACKAGE_HOMEPAGE
      \ CPACK_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION
      \ CPACK_GENERATOR
      \ CPACK_INCLUDE_TOPLEVEL_DIRECTORY
      \ CPACK_INSTALL_SCRIPT
      \ CPACK_MONOLITHIC_INSTALL
      \ CPACK_PACKAGE_CHECKSUM
      \ CPACK_PACKAGE_CONTACT
      \ CPACK_PACKAGE_DESCRIPTION_FILE
      \ CPACK_PACKAGE_FILE_NAME
      \ CPACK_PACKAGE_INSTALL_DIRECTORY
      \ CPACK_PACKAGE_NAME
      \ CPACK_PACKAGE_VENDOR
      \ CPACK_PACKAGING_INSTALL_PREFIX
      \ CPACK_RESOURCE_FILE_LICENSE
      \ CPACK_RESOURCE_FILE_README
      \ CPACK_SET_DESTDIR
      \ CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION
      \ CTEST_BINARY_DIRECTORY
      \ CTEST_BUILD_COMMAND
      \ CTEST_BUILD_NAME
      \ CTEST_BZR_COMMAND
      \ CTEST_BZR_UPDATE_OPTIONS
      \ CTEST_CHECKOUT_COMMAND
      \ CTEST_CONFIGURATION_TYPE
      \ CTEST_CONFIGURE_COMMAND
      \ CTEST_COVERAGE_COMMAND
      \ CTEST_COVERAGE_EXTRA_FLAGS
      \ CTEST_CURL_OPTIONS
      \ CTEST_CVS_CHECKOUT
      \ CTEST_CVS_COMMAND
      \ CTEST_CVS_UPDATE_OPTIONS
      \ CTEST_DROP_LOCATION
      \ CTEST_DROP_METHOD
      \ CTEST_DROP_SITE
      \ CTEST_DROP_SITE_CDASH
      \ CTEST_DROP_SITE_PASSWORD
      \ CTEST_DROP_SITE_USER
      \ CTEST_GIT_COMMAND
      \ CTEST_GIT_UPDATE_CUSTOM
      \ CTEST_GIT_UPDATE_OPTIONS
      \ CTEST_HG_COMMAND
      \ CTEST_HG_UPDATE_OPTIONS
      \ CTEST_MEMORYCHECK_COMMAND
      \ CTEST_MEMORYCHECK_COMMAND_OPTIONS
      \ CTEST_MEMORYCHECK_SANITIZER_OPTIONS
      \ CTEST_MEMORYCHECK_SUPPRESSIONS_FILE
      \ CTEST_MEMORYCHECK_TYPE
      \ CTEST_NIGHTLY_START_TIME
      \ CTEST_P4_CLIENT
      \ CTEST_P4_COMMAND
      \ CTEST_P4_OPTIONS
      \ CTEST_P4_UPDATE_OPTIONS
      \ CTEST_SCP_COMMAND
      \ CTEST_SITE
      \ CTEST_SOURCE_DIRECTORY
      \ CTEST_SVN_COMMAND
      \ CTEST_SVN_OPTIONS
      \ CTEST_SVN_UPDATE_OPTIONS
      \ CTEST_TEST_TIMEOUT
      \ CTEST_TRIGGER_SITE
      \ CTEST_UPDATE_COMMAND
      \ CTEST_UPDATE_OPTIONS
      \ CTEST_UPDATE_VERSION_ONLY
      \ CTEST_USE_LAUNCHERS
      \ CYGWIN
      \ ENV
      \ EXECUTABLE_OUTPUT_PATH
      \ LIBRARY_OUTPUT_PATH
      \ MINGW
      \ MSVC
      \ MSVC10
      \ MSVC11
      \ MSVC12
      \ MSVC14
      \ MSVC60
      \ MSVC70
      \ MSVC71
      \ MSVC80
      \ MSVC90
      \ MSVC_IDE
      \ MSVC_VERSION
      \ PACKAGE_INIT
      \ PROJECT_BINARY_DIR
      \ PROJECT_NAME
      \ PROJECT_SOURCE_DIR
      \ PROJECT_VERSION
      \ PROJECT_VERSION_MAJOR
      \ PROJECT_VERSION_MINOR
      \ PROJECT_VERSION_PATCH
      \ PROJECT_VERSION_TWEAK
      \ UNIX
      \ WIN32
      \ WINCE
      \ WINDOWS_PHONE
      \ WINDOWS_STORE
      \ XCODE_VERSION
      \ contained

" }}}

" constants {{{
syntax match cmakePolicy /CMP\d\d\d\d/ contained
syntax case ignore
syntax keyword cmakeBoolean ON YES TRUE Y OFF NO FALSE N contained
syntax case match
syntax keyword cmakeConstant AVAILABLE_PHYSICAL_MEMORY
      \ AVAILABLE_VIRTUAL_MEMORY
      \ Build
      \ Configure
      \ Coverage
      \ CRLF
      \ DEFAULT_MSG
      \ DOS
      \ ExtraFiles
      \ FIXED
      \ FQDN
      \ FREE
      \ HOSTNAME
      \ IS_64BIT
      \ LF
      \ MemCheck
      \ NEW
      \ NONE
      \ Notes
      \ NUMBER_OF_LOGICAL_CORES
      \ NUMBER_OF_PHYSICAL_CORES
      \ OLD
      \ Start
      \ Submit
      \ Test
      \ TOTAL_PHYSICAL_MEMORY
      \ TOTAL_VIRTUAL_MEMORY
      \ UNIX
      \ Update
      \ Upload
      \ WIN32
      \ contained
" }}}

" command options {{{
syntax match cmakeOption /@ONLY/ contained
syntax keyword cmakeOption ABSOLUTE
      \ AFTER
      \ ALG0
      \ ALIAS
      \ ALL
      \ ALPHABET
      \ AND
      \ APPEND
      \ APPEND_STRING
      \ ARCHIVE
      \ ARGS
      \ ASCII
      \ AUTHOR_WARNING
      \ BEFORE
      \ BRIEF_DOCS
      \ BUILD
      \ BUILD_COMMAND
      \ BUILD_IN_SOURCE
      \ BUNDLE
      \ BYPRODUCTS
      \ CACHE
      \ CACHED_VARIABLE
      \ CDASH_UPDLOAD
      \ CDASH_UPDLOAD_TYPE
      \ CLEAR
      \ CMAKE_FIND_ROOT_PATH_BOTH
      \ CMAKE_FLAGS
      \ CODE
      \ COMMAND
      \ COMMENT
      \ COMPARE
      \ COMPATIBILITY 
      \ COMPILE_DEFINITIONS
      \ COMPILE_RESULT_VAR
      \ COMPILE_OUTPUT_VARIABLE
      \ COMPONENT
      \ COMPONENTS
      \ CONCAT
      \ CONDITION
      \ CONFIG
      \ CONFIGS
      \ CONFIGURATION
      \ CONFIGURATIONS
      \ CONFIGURE
      \ CONFIGURE_COMMAND
      \ CONTENT
      \ COPY
      \ COPY_FILE
      \ COPY_FILE_ERROR
      \ COPYONLY
      \ debug
      \ DEFINED
      \ DEFINITION
      \ DEPENDS
      \ DEPRECATION
      \ DESCRIPTION
      \ DESTINATION
      \ DIRECTORY
      \ DIRECTORY_PERMISSIONS
      \ DOC
      \ DOWNLOAD
      \ DOWNLOAD_COMMAND
      \ ENCODING
      \ END
      \ ENV
      \ EQUAL
      \ ERROR_FILE
      \ ERROR_QUIET
      \ ERROR_STRIP_TRAILING_WHITESPACE
      \ ERROR_VARIABLE
      \ ESCAPE_QUOTES
      \ EXACT
      \ EXCLUDE
      \ EXCLUDE_FROM_ALL
      \ EXCLUDE_LABEL
      \ EXISTS
      \ EXPECTED_HASH
      \ EXPECTED_MD5
      \ EXPORT
      \ EXPORT_LINK_INTERFACE_LIBRARIES
      \ EXPR
      \ EXT
      \ EXTRA_INCLUDE
      \ FATAL_ERROR
      \ FILE
      \ FILE_PERMISSIONS
      \ FILES
      \ FILES_MATCHING
      \ FILTER
      \ FIND
      \ FOLLOW_SYMLINKS
      \ FORCE
      \ FRAMEWORK
      \ FULL_DOCS
      \ FUNCTION
      \ general
      \ GENERATE
      \ GENEX_STRIP
      \ GET
      \ GLOB
      \ GLOB_RECURSE
      \ GLOBAL
      \ GREATER
      \ GUARD
      \ GUID
      \ HEX
      \ HINTS
      \ HOMEPAGE_URL 
      \ IMPLICIT_DEPENDS
      \ IMPORTED
      \ IN
      \ INACTIVITY_TIMEOUT
      \ INCLUDE
      \ INCLUDE_INTERNALS
      \ INCLUDES
      \ INCLUDE_LABEL
      \ INHERITED
      \ INPUT
      \ INPUT_FILE
      \ INSERT
      \ INSTALL
      \ INSTALL_COMMAND
      \ INSTALL_DESTINATION 
      \ INTERFACE
      \ IS_ABSOLUTE
      \ IS_DIRECTORY
      \ IS_NEWER_THAN
      \ IS_SYMLINK
      \ ITEMS
      \ LABELS
      \ LANGUAGES
      \ LENGTH
      \ LENGTH_MAXIMUM
      \ LENGTH_MINIMUM
      \ LESS
      \ LIBRARY
      \ LIMIT
      \ LIMIT_COUNT
      \ LIMIT_INPUT
      \ LIMIT_OUTPUT
      \ LINK_INTERFACE_LIBRARIES
      \ LINK_LIBRARIES
      \ LINK_PRIVATE
      \ LINK_PUBLIC
      \ LIST_DIRECTORIES
      \ LISTS
      \ LOCK
      \ LOG
      \ MACOSX_BUNDLE
      \ MAIN_DEPENDENCY
      \ MAKE_C_IDENTIFIER
      \ MAKE_DIRECTORY
      \ MATCH
      \ MATCHALL
      \ MATCHES
      \ MD5
      \ MESSAGE_NEVER
      \ MODULE
      \ NAME
      \ NAMELINK_ONLY
      \ NAMELINK_SKIP
      \ NAME_WE
      \ NAMES
      \ NAMES_PER_DIR
      \ NAMESPACE
      \ NEW_PROCESS
      \ NEWLINE_CONSUME
      \ NEWLINE_STYLE
      \ NO_CHECK_REQUIRED_COMPONENTS_MACRO
      \ NO_CMAKE_BUILDS_PATH
      \ NO_CMAKE_ENVIRONMENT_PATH
      \ NO_CMAKE_FIND_ROOT_PATH
      \ NO_CMAKE_PACKAGE_REGISTRY
      \ NO_CMAKE_PATH
      \ NO_CMAKE_SYSTEM_PACKAGE_REGISTRY
      \ NO_CMAKE_SYSTEM_PATH
      \ NO_DEFAULT_PATH
      \ NO_HEX_CONVERSION
      \ NO_MODULE
      \ NO_POLICY_SCOPE
      \ NO_SET_AND_CHECK_MACRO
      \ NO_SOURCE_PERMISSIONS
      \ NO_SYSTEM_ENVIRONMENT_PATH
      \ NOT
      \ NOTEQUAL
      \ NUMBER_ERRORS
      \ NUMBER_WARNINGS
      \ OBJECT
      \ OFFSET
      \ ONLY_CMAKE_FIND_ROOT_PATH
      \ optimized
      \ OPTIONAL
      \ OPTIONAL_COMPONENTS
      \ OPTIONS
      \ OR
      \ OUTPUT
      \ OUTPUT_FILE
      \ OUTPUT_QUIET
      \ OUTPUT_STRIP_TRAILING_WHITESPACE
      \ OUTPUT_VARIABLE
      \ PACKAGE
      \ PARALLEL_LEVEL
      \ PARENT_SCOPE
      \ PARTS
      \ PATH
      \ PATHS
      \ PATH_SUFFIXES
      \ PATH_VARS
      \ PATTERN
      \ PERMISSIONS
      \ PLATFORM
      \ POLICY
      \ POP
      \ POST_BUILD
      \ PRE_BUILD
      \ PRE_LINK
      \ PRIVATE
      \ PRIVATE_HEADER
      \ PROCESS
      \ PROGRAM
      \ PROGRAMS
      \ PROGRAM_ARGS
      \ PROJECT_NAME
      \ PROPERTIES
      \ PROPERTY
      \ PUBLIC
      \ PUBLIC_HEADER
      \ PUSH
      \ QUERY
      \ QUIET
      \ RANDOM
      \ RANDOM_SEED
      \ RANGE
      \ READ
      \ READ_WITH_PREFIX
      \ REALPATH
      \ REGEX
      \ REGULAR_EXPRESSION
      \ RELATIVE
      \ RELATIVE_PATH
      \ RELEASE
      \ REMOVE
      \ REMOVE_AT
      \ REMOVE_DUPLICATES
      \ REMOVE_ITEM
      \ REMOVE_RECURSE
      \ RENAME
      \ REPLACE
      \ REQUIRED
      \ RESOURCE
      \ RESULT
      \ RESULT_VAR
      \ RESULT_VARIABLE
      \ RETRY_COUNT
      \ RETRY_DELAY
      \ RETURN_VALUE
      \ REVERSE
      \ RUN_OUTPUT_VARIABLE
      \ RUN_RESULT_VAR
      \ RUNTIME
      \ SCHEDULE_RANDOM
      \ SCRIPT
      \ SEND_ERROR
      \ SET
      \ SHA1
      \ SHA224
      \ SHA256
      \ SHA384
      \ SHA512
      \ SHARED
      \ SHOW_PROGRESS
      \ SORT
      \ SOURCE
      \ SOURCE_DIR
      \ SOURCES
      \ START
      \ STATIC
      \ STATUS
      \ STOP_TIME
      \ STRIDE
      \ STRINGS
      \ STREQUAL
      \ STRGREATER
      \ STRIP
      \ STRLESS
      \ SUBSTRING
      \ SYSTEM
      \ TARGET
      \ TARGETS
      \ TEST
      \ TIMESTAMP
      \ TIMEOUT
      \ TLS_CAINFO
      \ TLS_VERIFY
      \ TO_CMAKE_PATH
      \ TO_NATIVE_PATH
      \ TOLOWER
      \ TOUPPER
      \ TRACK
      \ TRANSFORM
      \ TYPE
      \ UNIX_COMMAND
      \ UNKNOWN
      \ UPLOAD
      \ UPPER
      \ USE_SOURCE_PERMISSIONS
      \ USES_TERMINAL
      \ UTC
      \ UUID
      \ VARIABLE
      \ VERBATIM
      \ VERSION
      \ VERSION_EQUAL
      \ VERSION_GREATER
      \ VERSION_LESS
      \ WARNING
      \ WIN32
      \ WINDOWS_COMMAND
      \ WORKING_DIRECTORY
      \ WRITE
      \ contained
" }}}

" commands {{{
syntax case ignore
syntax keyword cmakeDeprecated build_name
      \ exec_program
      \ export_library_dependencies
      \ install_files
      \ install_programs
      \ install_targets
      \ make_directory
      \ output_required_files
      \ remove
      \ subdir_depends
      \ subdirs
      \ use_mangled_mesa
      \ utility_source
      \ variable_requires
      \ write_file

syntax keyword ctestCommand ctest_build
      \ ctest_configure
      \ ctest_coverage
      \ ctest_empty_binary_directory
      \ ctest_memcheck
      \ ctest_read_custom_files
      \ ctest_run_script
      \ ctest_sleep
      \ ctest_start
      \ ctest_submit
      \ ctest_test
      \ ctest_update
      \ ctest_upload

syntax keyword cmakeCommand add_compile_options
      \ add_custom_command
      \ add_custom_target
      \ add_definitions
      \ add_dependencies
      \ add_executable
      \ add_library
      \ add_subdirectory
      \ add_test
      \ aux_source_directory
      \ break
      \ build_command
      \ cmake_host_system_information
      \ cmake_minimum_required
      \ cmake_parse_arguments
      \ cmake_policy
      \ configure_file
      \ configure_package_config_file
      \ continue
      \ create_test_sourcelist
      \ define_property
      \ else
      \ elseif
      \ enable_language
      \ enable_testing
      \ endforeach
      \ endfunction
      \ endif
      \ endmacro
      \ endwhile
      \ execute_process
      \ export
      \ ExternalProject_Add
      \ ExternalProject_Get_Property
      \ file
      \ find_file
      \ find_library
      \ find_package
      \ find_package_handle_standard_args
      \ find_path
      \ find_program
      \ fltk_wrap_ui
      \ foreach
      \ function
      \ get_cmake_property
      \ get_directory_property
      \ get_filename_component
      \ get_property
      \ get_source_file_property
      \ get_target_property
      \ get_test_property
      \ if
      \ include
      \ include_directories
      \ include_external_msproject
      \ include_guard
      \ include_regular_expression
      \ install
      \ link_directories
      \ link_libraries
      \ list
      \ load_cache
      \ load_command
      \ macro
      \ mark_as_advanced
      \ math
      \ message
      \ option
      \ project
      \ protobuf_generate_cpp
      \ qt_wrap_cpp
      \ qt_wrap_ui
      \ remove_definitions
      \ return
      \ separate_arguments
      \ set
      \ set_and_check
      \ set_directory_properties
      \ set_property
      \ set_source_files_properties
      \ set_target_properties
      \ set_tests_properties
      \ site_name
      \ source_group
      \ string
      \ target_compile_definitions
      \ target_compile_features
      \ target_compile_options
      \ target_include_directories
      \ target_link_libraries
      \ target_sources
      \ try_compile
      \ try_run
      \ unset
      \ variable_watch
      \ while
      \ write_basic_package_version_file
syntax case match
" }}}

" properties {{{
" deprecated properties...
syntax keyword cmakeDeprecated AUTOMOC_TARGETS_FOLDER
      \ DEFINITIONS
      \ HAS_CXX
      \ IMPORTED_LINK_INTERFACE_LIBRARIES
      \ POST_INSTALL_SCRIPT
      \ PRE_INSTALL_SCRIPT
syntax match cmakeDeprecated /[a-zA-Z0-9_]\+_OUTPUT_NAME/
syntax match cmakeDeprecated /\(IMPORTED_LINK_INTERFACE_LIBRARIES\|COMPILE_DEFINITIONS\)_[a-zA-Z0-9_]\+/

syntax match cmakeProperty /[a-zA-Z0-9_]\+_\(POSTFIX\|VISIBILITY_PRESET\)/ contained
syntax match cmakeProperty /\(INTERPROCEDURAL_OPTIMIZATION\|VS_GLOBAL_SECTION_P\(OST\|RE\)\|ARCHIVE_OUTPUT_DIRECTORY\|ARCHIVE_OUTPUT_NAME\|COMPILE_PDB_NAME\|COMPILE_PDB_OUTPUT_DIRECTORY\|EXCLUDE_FROM_DEFAULT_BUILD\|IMPORTED_IMPLIB\|IMPORTED_LINK_DEPENDENT_LIBRARIES\|IMPORTED_LINK_INTERFACE_LANGUAGES\|IMPORTED_LINK_INTERFACE_MULTIPLICITY\|IMPORTED_LOCATION\|IMPORTED_NO_SONAME\|IMPORTED_SONAME\|LIBRARY_OUTPUT_DIRECTORY\|LIBRARY_OUTPUT_NAME\|LINK_FLAGS\|LINK_INTERFACE_LIBRARIES\|LINK_INTERFACE_MULTIPLICITY\|LOCATION\|MAP_IMPORTED_CONFIG\|OSX_ARCHITECTURES\|OUTPUT_NAME\|PDB_NAME\|PDB_OUTPUT_DIRECTORY\|RUNTIME_OUTPUT_DIRECTORY\|RUNTIME_OUTPUT_NAME\|STATIC_LIBRARY_FLAGS\|VS_GLOBAL\|XCODE_ATTRIBUTE\)_[a-zA-Z0-9_]/ contained

syntax keyword cmakeProperty ABSTRACT
      \ ADDITIONAL_MAKE_CLEAN_FILES
      \ ADVANCED
      \ ALIASED_TARGET
      \ ALLOW_DUPLICATE_CUSTOM_TARGETS
      \ ANDROID_API
      \ ANDROID_API_MIN
      \ ANDROID_GUI
      \ ARCHIVE_OUTPUT_DIRECTORY
      \ ARCHIVE_OUTPUT_NAME
      \ ATTACHED_FILES
      \ ATTACHED_FILES_ON_FAIL
      \ AUTOGEN_TARGETS_FOLDER
      \ AUTOGEN_TARGET_DEPENDS
      \ AUTOMOC
      \ AUTOMOC_MOC_OPTIONS
      \ AUTORCC
      \ AUTORCC_OPTIONS
      \ AUTOUIC
      \ AUTOUIC_OPTIONS
      \ BUILD_WITH_INSTALL_RPATH
      \ BUNDLE
      \ BUNDLE_EXTENSION
      \ CACHE_VARIABLES
      \ CLEAN_NO_CUSTOM
      \ CMAKE_CONFIGURE_DEPENDS
      \ CMAKE_CXX_KNOWN_FEATURES
      \ CMAKE_C_KNOWN_FEATURES
      \ COMPATIBLE_INTERFACE_BOOL
      \ COMPATIBLE_INTERFACE_NUMBER_MAX
      \ COMPATIBLE_INTERFACE_NUMBER_MIN
      \ COMPATIBLE_INTERFACE_STRING
      \ COMPILE_DEFINITIONS
      \ COMPILE_FEATURES
      \ COMPILE_FLAGS
      \ COMPILE_OPTIONS
      \ COMPILE_PDB_NAME
      \ COMPILE_PDB_OUTPUT_DIRECTORY
      \ COST
      \ CPACK_NEVER_OVERWRITE
      \ CPACK_PERMANENT
      \ CPACK_WIX_ACL
      \ CXX_EXTENSIONS
      \ CXX_STANDARD
      \ CXX_STANDARD_REQUIRED
      \ C_EXTENSIONS
      \ C_STANDARD
      \ C_STANDARD_REQUIRED
      \ DEBUG_CONFIGURATIONS
      \ DEFINE_SYMBOL
      \ DEPENDS
      \ DISABLED_FEATURES
      \ ECLIPSE_EXTRA_NATURES
      \ ENABLED_FEATURES
      \ ENABLED_LANGUAGES
      \ ENABLE_EXPORTS
      \ ENVIRONMENT
      \ EXCLUDE_FROM_ALL
      \ EXCLUDE_FROM_DEFAULT_BUILD
      \ EXPORT_NAME
      \ EXTERNAL_OBJECT
      \ EchoString
      \ FAIL_REGULAR_EXPRESSION
      \ FIND_LIBRARY_USE_LIB64_PATHS
      \ FIND_LIBRARY_USE_OPENBSD_VERSIONING
      \ FOLDER
      \ FRAMEWORK
      \ Fortran_FORMAT
      \ Fortran_MODULE_DIRECTORY
      \ GENERATED
      \ GENERATOR_FILE_NAME
      \ GLOBAL_DEPENDS_DEBUG_MODE
      \ GLOBAL_DEPENDS_NO_CYCLES
      \ GNUtoMS
      \ HEADER_FILE_ONLY
      \ HELPSTRING
      \ IMPLICIT_DEPENDS_INCLUDE_TRANSFORM
      \ IMPORTED
      \ IMPORTED_CONFIGURATIONS
      \ IMPORTED_IMPLIB
      \ IMPORTED_LINK_DEPENDENT_LIBRARIES
      \ IMPORTED_LINK_INTERFACE_LANGUAGES
      \ IMPORTED_LINK_INTERFACE_MULTIPLICITY
      \ IMPORTED_LOCATION
      \ IMPORTED_NO_SONAME
      \ IMPORTED_SONAME
      \ IMPORT_PREFIX
      \ IMPORT_SUFFIX
      \ INCLUDE_DIRECTORIES
      \ INCLUDE_REGULAR_EXPRESSION
      \ INSTALL_NAME_DIR
      \ INSTALL_RPATH
      \ INSTALL_RPATH_USE_LINK_PATH
      \ INTERFACE_AUTOUIC_OPTIONS
      \ INTERFACE_COMPILE_DEFINITIONS
      \ INTERFACE_COMPILE_FEATURES
      \ INTERFACE_COMPILE_OPTIONS
      \ INTERFACE_INCLUDE_DIRECTORIES
      \ INTERFACE_LINK_LIBRARIES
      \ INTERFACE_POSITION_INDEPENDENT_CODE
      \ INTERFACE_SOURCES
      \ INTERFACE_SYSTEM_INCLUDE_DIRECTORIES
      \ INTERPROCEDURAL_OPTIMIZATION
      \ IN_TRY_COMPILE
      \ JOB_POOLS
      \ JOB_POOL_COMPILE
      \ JOB_POOL_LINK
      \ KEEP_EXTENSION
      \ LABELS
      \ LANGUAGE
      \ LIBRARY_OUTPUT_DIRECTORY
      \ LIBRARY_OUTPUT_NAME
      \ LINKER_LANGUAGE
      \ LINK_DEPENDS
      \ LINK_DEPENDS_NO_SHARED
      \ LINK_DIRECTORIES
      \ LINK_FLAGS
      \ LINK_INTERFACE_LIBRARIES
      \ LINK_INTERFACE_MULTIPLICITY
      \ LINK_LIBRARIES
      \ LINK_SEARCH_END_STATIC
      \ LINK_SEARCH_START_STATIC
      \ LISTFILE_STACK
      \ LOCATION
      \ MACOSX_BUNDLE
      \ MACOSX_BUNDLE_INFO_PLIST
      \ MACOSX_FRAMEWORK_INFO_PLIST
      \ MACOSX_PACKAGE_LOCATION
      \ MACOSX_RPATH
      \ MACROS
      \ MEASUREMENT
      \ MODIFIED
      \ NAME
      \ NO_SONAME
      \ NO_SYSTEM_FROM_IMPORTED
      \ OBJECT_DEPENDS
      \ OBJECT_OUTPUTS
      \ OSX_ARCHITECTURES
      \ OUTPUT_NAME
      \ PACKAGES_FOUND
      \ PACKAGES_NOT_FOUND
      \ PARENT_DIRECTORY
      \ PASS_REGULAR_EXPRESSION
      \ PDB_NAME
      \ PDB_OUTPUT_DIRECTORY
      \ POSITION_INDEPENDENT_CODE
      \ PREDEFINED_TARGETS_FOLDER
      \ PREFIX
      \ PRIVATE_HEADER
      \ PROCESSORS
      \ PROJECT_LABEL
      \ PUBLIC_HEADER
      \ REPORT_UNDEFINED_PROPERTIES
      \ REQUIRED_FILES
      \ RESOURCE
      \ RESOURCE_LOCK
      \ RULE_LAUNCH_COMPILE
      \ RULE_LAUNCH_CUSTOM
      \ RULE_LAUNCH_LINK
      \ RULE_MESSAGES
      \ RUNTIME_OUTPUT_DIRECTORY
      \ RUNTIME_OUTPUT_NAME
      \ RUN_SERIAL
      \ SKIP_BUILD_RPATH
      \ SKIP_RETURN_CODE
      \ SOURCES
      \ SOVERSION
      \ STATIC_LIBRARY_FLAGS
      \ STRINGS
      \ SUFFIX
      \ SYMBOLIC
      \ TARGET_ARCHIVES_MAY_BE_SHARED_LIBS
      \ TARGET_SUPPORTS_SHARED_LIBS
      \ TEST_INCLUDE_FILE
      \ TIMEOUT
      \ TYPE
      \ USE_FOLDERS
      \ VALUE
      \ VARIABLES
      \ VERSION
      \ VISIBILITY_INLINES_HIDDEN
      \ VS_DEPLOYMENT_CONTENT
      \ VS_DEPLOYMENT_LOCATION
      \ VS_DOTNET_REFERENCES
      \ VS_DOTNET_TARGET_FRAMEWORK_VERSION
      \ VS_GLOBAL_KEYWORD
      \ VS_GLOBAL_PROJECT_TYPES
      \ VS_GLOBAL_ROOTNAMESPACE
      \ VS_KEYWORD
      \ VS_SCC_AUXPATH
      \ VS_SCC_LOCALPATH
      \ VS_SCC_PROJECTNAME
      \ VS_SCC_PROVIDER
      \ VS_SHADER_ENTRYPOINT
      \ VS_SHADER_FLAGS
      \ VS_SHADER_MODEL
      \ VS_SHADER_TYPE
      \ VS_WINRT_COMPONENT
      \ VS_WINRT_EXTENSIONS
      \ VS_WINRT_REFERENCES
      \ WILL_FAIL
      \ WIN32_EXECUTABLE
      \ WORKING_DIRECTORY
      \ WRAP_EXCLUDE
      \ XCODE_EXPLICIT_FILE_TYPE
      \ XCODE_LAST_KNOWN_FILE_TYPE
      \ contained
" }}}

" generator expressions {{{
syntax keyword cmakeGenExprOption C_COMPILER_ID
      \ C_COMPILER_VERSION
      \ CONFIG
      \ CONFIGURATION
      \ CXX_COMPILER_ID
      \ CXX_COMPILER_VERSION
      \ INSTALL_PREFIX
      \ PLATFORM_ID
      \ TARGET_FILE
      \ TARGET_FILE_DIR
      \ TARGET_FILE_NAME
      \ TARGET_LINKER_FILE
      \ TARGET_LINKER_FILE_DIR
      \ TARGET_LINKER_FILE_NAME
      \ TARGET_PDB_FILE
      \ TARGET_PDB_FILE_DIR
      \ TARGET_PDB_FILE_NAME
      \ TARGET_PROPERTY
      \ TARGET_SONAME_FILE
      \ TARGET_SONAME_FILE_DIR
      \ TARGET_SONAME_FILE_NAME
      \ TARGET_POLICY
      \ contained
syntax region cmakeGenExpr start=/$</ end=/>/ contained contains=cmakeGenExprOption,cmakeOption,cmakeProperty,cmakeType
" }}}

" Define the default highlighting.
highlight default link cmakeBoolean boolean
highlight default link cmakeCommand statement
highlight default link cmakeComment comment
highlight default link cmakeConstant constant
highlight default link cmakeDeprecated error
highlight default link cmakeFloat float
highlight default link cmakeFormat specialchar
highlight default link cmakeGenExpr constant
highlight default link cmakeGenExprOption constant
highlight default link cmakeInteger number
highlight default link cmakeOption operator
highlight default link cmakePolicy macro
highlight default link cmakeProperty constant
highlight default link cmakeRegistry underlined
highlight default link cmakeString string
highlight default link cmakeTodo todo
highlight default link cmakeType type
highlight default link cmakeVariable identifier
highlight default link cmakeVariableReference identifier
highlight default link cmakeVersion float
highlight default link ctestCommand statement

" for default group names, help group-name

let b:current_syntax = "cmake"
let &cpo = s:keepcpo
unlet s:keepcpo
