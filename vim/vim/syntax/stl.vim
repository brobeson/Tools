" Vim syntax file
" Language:     C++ STL
" Maintainer:   brobeson (http://github.com/brobeson/Tools)
" Last Change:  2016 May 8

" use this variable to control whether object methods should be
" highlighted.
let stl_highlight_members = 1
"let cpp_no_cpp11 = 1
"let cpp_no_cpp14 = 1
"let cpp_no_cpp17 = 1

syntax keyword stlNamespaceId std

syntax keyword stlMethodId      contained denorm_min        " std::numeric_limits<T>::denorm_min()
syntax keyword stlConstantId    contained digits    " std::numeric_limits<T>::digits
syntax keyword stlConstantId    contained digits10    " std::numeric_limits<T>::digits10
syntax keyword stlMethodId      contained epsilon           " std::numeric_limits<T>::epsilon()
syntax keyword stlConstantId      contained has_denorm          " std::numeric_limits<T>::has_denorm
syntax keyword stlConstantId      contained has_denorm_loss          " std::numeric_limits<T>::has_denorm_loss
syntax keyword stlConstantId      contained has_infinity          " std::numeric_limits<T>::has_infinity
syntax keyword stlConstantId      contained has_quiet_NaN          " std::numeric_limits<T>::has_quiet_NaN
syntax keyword stlConstantId      contained has_signaling_NaN          " std::numeric_limits<T>::has_signaling_NaN
syntax keyword stlMethodId      contained infinity          " std::numeric_limits<T>::infinity()
syntax keyword stlConstantId    contained is_bounded    " std::numeric_limits<T>::is_bounded
syntax keyword stlConstantId    contained is_exact    " std::numeric_limits<T>::is_exact
syntax keyword stlConstantId    contained is_iec559    " std::numeric_limits<T>::is_iec559
syntax keyword stlConstantId    contained is_integer    " std::numeric_limits<T>::is_integer
syntax keyword stlConstantId    contained is_modulo    " std::numeric_limits<T>::is_modulo
syntax keyword stlConstantId    contained is_signed    " std::numeric_limits<T>::is_signed
syntax keyword stlConstantId    contained is_specialized    " std::numeric_limits<T>::is_specialized
syntax keyword stlMethodId      contained max               " std::numeric_limits<T>::max()
syntax keyword stlConstantId    contained max_exponent           " std::numeric_limits<T>::max_exponent
syntax keyword stlConstantId    contained max_exponent10           " std::numeric_limits<T>::max_exponent10
syntax keyword stlMethodId      contained min               " std::numeric_limits<T>::min()
syntax keyword stlConstantId    contained min_exponent           " std::numeric_limits<T>::min_exponent
syntax keyword stlConstantId    contained min_exponent10           " std::numeric_limits<T>::min_exponent10
syntax keyword stlClassId       contained numeric_limits    " std::numeric_limits<T>
syntax keyword stlMethodId      contained quiet_NaN         " std::numeric_limits<T>::quiet_NaN()
syntax keyword stlConstantId    contained radix           " std::numeric_limits<T>::radix
syntax keyword stlMethodId      contained round_error       " std::numeric_limits<T>::round_error()
syntax keyword stlConstantId    contained round_style           " std::numeric_limits<T>::round_style
syntax keyword stlMethodId      contained signaling_NaN     " std::numeric_limits<T>::signaling_NaN()
syntax keyword stlConstantId    contained tinyness_before           " std::numeric_limits<T>::tinyness_before
syntax keyword stlConstantId    contained traps           " std::numeric_limits<T>::traps
    
" classes
syntax match stlClass /std::numeric_limits/ contains=stlNamespaceId,stlClassId
" static methods
syntax match stlMethod /::\(denorm_min\|epsilon\|infinity\|max\|min\|quiet_NaN\|round_error\|signaling_NaN\)(/ contains=stlMethodId

if !exists('cpp_no_cpp11') "{{{
    syntax keyword stlMethodId      contained lowest  " std::numeric_limits<T>::lowest()
    syntax keyword stlConstantId    contained digits10    " std::numeric_limits<T>::digits10
    
    " static methods
    syntax match stlMethod /::lowest(/ contains=stlMethodId
endif "}}}

" utilities {{{
" type support {{{
" all versions {{{
syntax keyword stlConstantId    is_specialized is_signed is_integer is_exact has_infinity
                            \   has_quiet_NaN has_signaling_NaN has_denorm has_denorm_loss
                            \   round_style is_iec559 is_bounded is_modulo digits digits10
                            \   max_digits10 " c++11
                            \   radix min_exponent min_exponent10 max_exponent max_exponent10
                            \   traps tinyness_before
syntax keyword stlMacroConstantId   INT8_MIN INT16_MIN INT32_MIN INT64_MIN
                                \   INT_FAST8_MIN INT_FAST16_MIN INT_FAST23_MIN INT_FAST64_MIN
                                \   INT_LEAST8_MIN INT_LEAST16_MIN INT_LEAST23_MIN INT_LEAST64_MIN
                                \   INTMAX_MIN INTPTR_MIN
                                \   INT8_MAX INT16_MAX INT32_MAX INT64_MAX
                                \   INT_FAST8_MAX INT_FAST16_MAX INT_FAST23_MAX INT_FAST64_MAX
                                \   INT_LEAST8_MAX INT_LEAST16_MAX INT_LEAST23_MAX INT_LEAST64_MAX
                                \   INTMAX_MAX INTPTR_MAX
                                \   UINT8_MAX UINT16_MAX UINT32_MAX UINT64_MAX
                                \   UINT_FAST8_MAX UINT_FAST16_MAX UINT_FAST23_MAX UINT_FAST64_MAX
                                \   UINT_LEAST8_MAX UINT_LEAST16_MAX UINT_LEAST23_MAX UINT_LEAST64_MAX
                                \   UINTMAX_MAX UINTPTR_MAX
                                \   PRId8 PRId16 PRId32 PRId64
                                \   PRIi8 PRIi16 PRIi32 PRIi64
                                \   PRIu8 PRIu16 PRIu32 PRIu64
                                \   PRIo8 PRIo16 PRIo32 PRIo64
                                \   PRIx8 PRIx16 PRIx32 PRIx64
                                \   PRIX8 PRIX16 PRIX32 PRIX64
                                \   PRIdLEAST8 PRIdLEAST16 PRIdLEAST32 PRIdLEAST64
                                \   PRIiLEAST8 PRIiLEAST16 PRIiLEAST32 PRIiLEAST64
                                \   PRIuLEAST8 PRIuLEAST16 PRIuLEAST32 PRIuLEAST64
                                \   PRIoLEAST8 PRIoLEAST16 PRIoLEAST32 PRIoLEAST64
                                \   PRIxLEAST8 PRIxLEAST16 PRIxLEAST32 PRIxLEAST64
                                \   PRIXLEAST8 PRIXLEAST16 PRIXLEAST32 PRIXLEAST64
                                \   PRIdFAST8 PRIdFAST16 PRIdFAST32 PRIdFAST64
                                \   PRIiFAST8 PRIiFAST16 PRIiFAST32 PRIiFAST64
                                \   PRIuFAST8 PRIuFAST16 PRIuFAST32 PRIuFAST64
                                \   PRIoFAST8 PRIoFAST16 PRIoFAST32 PRIoFAST64
                                \   PRIxFAST8 PRIxFAST16 PRIxFAST32 PRIxFAST64
                                \   PRIXFAST8 PRIXFAST16 PRIXFAST32 PRIXFAST64
                                \   PRIdMAX8 PRIdPTR
                                \   PRIiMAX8 PRIiPTR
                                \   PRIuMAX8 PRIuPTR
                                \   PRIoMAX8 PRIoPTR
                                \   PRIxMAX8 PRIxPTR
                                \   PRIXMAX8 PRIXPTR
                                \   SCNd8 SCNd16 SCNd32 SCNd64
                                \   SCNi8 SCNi16 SCNi32 SCNi64
                                \   SCNu8 SCNu16 SCNu32 SCNu64
                                \   SCNo8 SCNo16 SCNo32 SCNo64
                                \   SCNx8 SCNx16 SCNx32 SCNx64
                                \   SCNX8 SCNX16 SCNX32 SCNX64
                                \   SCNdLEAST8 SCNdLEAST16 SCNdLEAST32 SCNdLEAST64
                                \   SCNiLEAST8 SCNiLEAST16 SCNiLEAST32 SCNiLEAST64
                                \   SCNuLEAST8 SCNuLEAST16 SCNuLEAST32 SCNuLEAST64
                                \   SCNoLEAST8 SCNoLEAST16 SCNoLEAST32 SCNoLEAST64
                                \   SCNxLEAST8 SCNxLEAST16 SCNxLEAST32 SCNxLEAST64
                                \   SCNXLEAST8 SCNXLEAST16 SCNXLEAST32 SCNXLEAST64
                                \   SCNdFAST8 SCNdFAST16 SCNdFAST32 SCNdFAST64
                                \   SCNiFAST8 SCNiFAST16 SCNiFAST32 SCNiFAST64
                                \   SCNuFAST8 SCNuFAST16 SCNuFAST32 SCNuFAST64
                                \   SCNoFAST8 SCNoFAST16 SCNoFAST32 SCNoFAST64
                                \   SCNxFAST8 SCNxFAST16 SCNxFAST32 SCNxFAST64
                                \   SCNXFAST8 SCNXFAST16 SCNXFAST32 SCNXFAST64
                                \   SCNdMAX8 SCNdPTR
                                \   SCNiMAX8 SCNiPTR
                                \   SCNuMAX8 SCNuPTR
                                \   SCNoMAX8 SCNoPTR
                                \   SCNxMAX8 SCNxPTR
                                \   SCNXMAX8 SCNXPTR
                                \   NULL
syntax keyword stdMacroFunctionId   offsetof
                                \   INT8_C INT16_C INT32_C INT64_C INTMAX_C
                                \   UINT8_C UINT16_C UINT32_C UINT64_C UINTMAX_C
syntax keyword stlTypeId contained  int8_t int16_t int32_t int64_t
                                \   int_fast8_t int_fast16_t int_fast32_t int_fast64_t
                                \   int_least8_t int_least16_t int_least32_t int_least64_t
                                \   intmax_t intptr_t
                                \   ptrdiff_t size_t
                                \   uint8_t uint16_t uint32_t uint64_t
                                \   uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
                                \   uint_least8_t uint_least16_t uint_least32_t uint_least64_t
                                \   uintmax_t uintptr_t
syntax match stlType /std::\(ptrdiff_t\|size_t\)/ contains=stlNamespaceId,stlTypeId
" }}}

if !exists('cpp_no_cpp11') " {{{
    syntax keyword stlContantId         nullptr
    syntax keyword stlMacroConstantId   __alignas_is_defined __bool_true_false_are_defined
    syntax keyword stlTypeId contained  max_align_t nullptr_t
    syntax match stlType /std::\(max_align_t\|nullptr_t\)/ contains=stlNamespaceId,stlTypeId
endif " }}}
" }}}
" }}}

" highlighting {{{
"highlight         link cConstant       stlMacroConstId
"highlight default link stlClassId      Structure
"highlight default link stlConstantId   Constant
"highlight default link stlEnumerationId    Structure
"highlight default link stlEnumeratorId Constant
"highlight default link stlError            Error
"highlight default link stlFunctionId   Function
"highlight default link stlMacroConstId Macro
"highlight default link stlMacroFuncId  Macro
"highlight default link stlMemberId     stlVariableId
highlight default link stlMethodId     Function
highlight default link stlNamespaceId  Structure
"highlight default link stlTypeId       Typedef
"highlight default link stlVariableId   Identifier
"}}}

