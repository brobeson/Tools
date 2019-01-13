" Vim syntax file
" Language:     C++ Guideline Support Library
" Maintainer:   brobeson (http://github.com/brobeson/Tools)
" Last Change:  2018 July 19
"
" TODO
" gsl_assert - macros
" multi_span
" string_span
" namespace gsl::details ??

" use this variable to control whether object methods should be
" highlighted.
let gsl_highlight_members = 1


" data members {{{
"if exists('gsl_highlight_members')
"    syntax keyword gslMember comp
"endif
" }}}

" enumerations {{{
"if !exists('cpp_no_cpp11')
"    syntax keyword gslEnumeration cv_status
"    syntax keyword gslEnumerator  async
"endif
"" }}}

syntax keyword gslNamespace gsl
syntax keyword gslClass basic_string_span
            \ byte
            \ fail_fast
            \ final_action
            \ multi_span_index
            \ narrowing_error
            \ not_null
            \ span
syntax keyword gslConstant dynamic_extent
            \ extent
            \ rank
syntax keyword gslFunction as_bytes
            \ as_writeable_bytes
            \ at
            \ copy
            \ ensure_sentinal
            \ ensure_z
            \ finally
            \ make_span
            \ narrow
            \ narrow_cast
            \ to_byte
            \ to_integer
syntax keyword gslMacroFunction Ensures Expects
syntax keyword gslMacroConstant GSL_TERMINATE_ON_CONTRACT_VIOLATION
            \ GSL_THROW_ON_CONTRACT_VIOLATION
            \ GSL_UNENFORCED_ON_CONTRACT_VIOLATION
syntax keyword gslTypeAlias basic_zstring
            \ const_iterator
            \ const_reference
            \ const_reverse_iterator
            \ cu16zstring
            \ cu32zstring
            \ cwzstring
            \ czstring
            \ element_type
            \ index
            \ index_type
            \ iterator
            \ owner
            \ pointer
            \ reference
            \ reverse_iterator
            \ size_type
            \ u16zstring
            \ u32zstring
            \ value_type
            \ wzstring
            \ zstring

if exists('gsl_highlight_members')
    syntax keyword gslMethod begin
                \ cbegin
                \ cend
                \ crbegin
                \ crend
                \ data
                \ empty
                \ end
                \ first
                \ get
                \ last
                \ rbegin
                \ rend
                \ size
                \ size_bytes
                \ subspan
endif
" }}}


"syntax keyword gslVariable default_random_engine

" highlighting {{{
highlight default link gslClass       Structure
highlight default link gslConstant    Constant
highlight default link gslEnumeration Structure
highlight default link gslEnumerator  Constant
highlight default link gslError         Error
highlight default link gslFunction    Function
highlight default link gslMacroConst  Macro
highlight default link gslMacroFunc   Macro
highlight default link gslMember      gslVariable
highlight default link gslMethod      Function
highlight default link gslNamespace   Structure
highlight default link gslType        Typedef
highlight default link gslVariable    entifier
"}}}

