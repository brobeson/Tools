" Vim syntax file
" Language:     C++ STL
" Maintainer:   brobeson (http://github.com/brobeson/Tools)
" Last Change:  2016 December 23

" use this variable to control whether object methods should be
" highlighted.
let stl_highlight_members = 1
"let cpp_no_cpp11 = 1
"let cpp_no_cpp14 = 1
"let cpp_no_cpp17 = 1

syntax keyword stlNamespaceId contained std

" classes {{{
    " all versions {{{
    syntax keyword stlClassId   contained allocator
    syntax keyword stlClassId   contained bad_alloc
    syntax keyword stlClassId   contained bad_cast
    syntax keyword stlClassId   contained bad_typeid
    syntax keyword stlClassId   contained basic_string
    syntax keyword stlClassId   contained char_traits
    syntax keyword stlClassId   contained complex
    syntax keyword stlClassId   contained deque
    syntax keyword stlClassId   contained list
    syntax keyword stlClassId   contained map
    syntax keyword stlClassId   contained mbstate_t
    syntax keyword stlClassId   contained multimap
    syntax keyword stlClassId   contained multiset
    syntax keyword stlClassId   contained nothrow_t
    syntax keyword stlClassId   contained numeric_limits
    syntax keyword stlClassId   contained priority_queue
    syntax keyword stlClassId   contained queue
    syntax keyword stlClassId   contained random_device
    syntax keyword stlClassId   contained raw_storage_iterator
    syntax keyword stlClassId   contained set
    syntax keyword stlClassId   contained stack
    syntax keyword stlClassId   contained type_info
    syntax keyword stlClassId   contained valarray
    syntax keyword stlClassId   contained value_compare
    syntax keyword stlClassId   contained vector
    syntax keyword stlClassId   contained wctrans_t
    syntax keyword stlClassId   contained wctype_t
    syntax keyword stlClassId   contained wint_t
    syntax match   stlClass     /\<std::\(allocator\|bad_\(alloc\|cast\|typeid\)\|basic_string\|char_traits\|complex\|deque\|list\|map\|mbstate_t\|multimap\|multiset\|nothrow_t\|numeric_limits\|priority_queue\|queue\|random_device\|raw_storage_iterator\|set\|stack\|type_info\|valarray\|vector\|wctrans_t\|wctype_t\|wint_t\)\>/ contains=stlNamespaceId,stlClassId
    syntax match   stlClass     /::value_compare/ contains=stlClassId
    " }}}

    " added in C++11 {{{
    if !exists('cpp_no_cpp11')
        syntax keyword stlClassId   contained add_const
        syntax keyword stlClassId   contained add_cv
        syntax keyword stlClassId   contained add_lvalue_reference
        syntax keyword stlClassId   contained add_pointer
        syntax keyword stlClassId   contained add_rvalue_reference
        syntax keyword stlClassId   contained add_volatile
        syntax keyword stlClassId   contained aligned_storage
        syntax keyword stlClassId   contained aligned_union
        syntax keyword stlClassId   contained alignment_of
        syntax keyword stlClassId   contained array
        syntax keyword stlClassId   contained adopt_lock_t
        syntax keyword stlClassId   contained bernoulli_distribution
        syntax keyword stlClassId   contained binomial_distribution
        syntax keyword stlClassId   contained cauchy_distribution
        syntax keyword stlClassId   contained chi_squared_distribution
        syntax keyword stlClassId   contained common_type
        syntax keyword stlClassId   contained condition_variable
        syntax keyword stlClassId   contained condition_variable_any
        syntax keyword stlClassId   contained conditional
        syntax keyword stlClassId   contained decay
        syntax keyword stlClassId   contained defer_lock_t
        syntax keyword stlClassId   contained discard_block_engine
        syntax keyword stlClassId   contained discrete_distribution
        syntax keyword stlClassId   contained enable_if
        syntax keyword stlClassId   contained exponential_distribution
        syntax keyword stlClassId   contained extent
        syntax keyword stlClassId   contained extreme_value_distribution
        syntax keyword stlClassId   contained fisher_f_distribution
        syntax keyword stlClassId   contained forward_list
        syntax keyword stlClassId   contained future
        syntax keyword stlClassId   contained future_error
        syntax keyword stlClassId   contained gamma_distribution
        syntax keyword stlClassId   contained geometric_distribution
        syntax keyword stlClassId   contained has_virtual_destructor
        syntax keyword stlClassId   contained id
        syntax keyword stlClassId   contained independent_bits_engine
        syntax keyword stlClassId   contained is_abstract
        syntax keyword stlClassId   contained is_arithmetic
        syntax keyword stlClassId   contained is_array
        syntax keyword stlClassId   contained is_assignable
        syntax keyword stlClassId   contained is_base_of
        syntax keyword stlClassId   contained is_class
        syntax keyword stlClassId   contained is_compound
        syntax keyword stlClassId   contained is_const
        syntax keyword stlClassId   contained is_constructible
        syntax keyword stlClassId   contained is_convertible
        syntax keyword stlClassId   contained is_copy_assignable
        syntax keyword stlClassId   contained is_copy_constructible
        syntax keyword stlClassId   contained is_default_constructible
        syntax keyword stlClassId   contained is_destructible
        syntax keyword stlClassId   contained is_empty
        syntax keyword stlClassId   contained is_enum
        syntax keyword stlClassId   contained is_floating_point
        syntax keyword stlClassId   contained is_function
        syntax keyword stlClassId   contained is_fundamental
        syntax keyword stlClassId   contained is_integral
        syntax keyword stlClassId   contained is_literal_type
        syntax keyword stlClassId   contained is_lvalue_reference
        syntax keyword stlClassId   contained is_member_function_pointer
        syntax keyword stlClassId   contained is_member_object_pointer
        syntax keyword stlClassId   contained is_member_pointer
        syntax keyword stlClassId   contained is_move_assignable
        syntax keyword stlClassId   contained is_move_constructible
        syntax keyword stlClassId   contained is_nothrow_assignable
        syntax keyword stlClassId   contained is_nothrow_constructible
        syntax keyword stlClassId   contained is_nothrow_copy_assignable
        syntax keyword stlClassId   contained is_nothrow_copy_constructible
        syntax keyword stlClassId   contained is_nothrow_default_constructible
        syntax keyword stlClassId   contained is_nothrow_destructible
        syntax keyword stlClassId   contained is_nothrow_move_assignable
        syntax keyword stlClassId   contained is_nothrow_move_constructible
        syntax keyword stlClassId   contained is_object
        syntax keyword stlClassId   contained is_pod
        syntax keyword stlClassId   contained is_pointer
        syntax keyword stlClassId   contained is_polymorphic
        syntax keyword stlClassId   contained is_reference
        syntax keyword stlClassId   contained is_rvalue_reference
        syntax keyword stlClassId   contained is_same
        syntax keyword stlClassId   contained is_scalar
        syntax keyword stlClassId   contained is_signed
        syntax keyword stlClassId   contained is_standard_layout
        syntax keyword stlClassId   contained is_trivial
        syntax keyword stlClassId   contained is_trivially_assignable
        syntax keyword stlClassId   contained is_trivially_constructible
        syntax keyword stlClassId   contained is_trivially_copy_assignable
        syntax keyword stlClassId   contained is_trivially_copy_constructible
        syntax keyword stlClassId   contained is_trivially_copyable
        syntax keyword stlClassId   contained is_trivially_default_constructible
        syntax keyword stlClassId   contained is_trivially_destructible
        syntax keyword stlClassId   contained is_trivially_move_assignable
        syntax keyword stlClassId   contained is_trivially_move_constructible
        syntax keyword stlClassId   contained is_union
        syntax keyword stlClassId   contained is_unsigned
        syntax keyword stlClassId   contained is_void
        syntax keyword stlClassId   contained is_volatile
        syntax keyword stlClassId   contained integral_constant
        syntax keyword stlClassId   contained linear_congruential_engine
        syntax keyword stlClassId   contained lock_guard
        syntax keyword stlClassId   contained lognormal_distribution
        syntax keyword stlClassId   contained make_signed
        syntax keyword stlClassId   contained make_unsigned
        syntax keyword stlClassId   contained mersenne_twister_engine
        syntax keyword stlClassId   contained mutex
        syntax keyword stlClassId   contained negative_binomial_distribution
        syntax keyword stlClassId   contained normal_distribution
        syntax keyword stlClassId   contained once_flag
        syntax keyword stlClassId   contained packaged_task
        syntax keyword stlClassId   contained piecewise_constant_distribution
        syntax keyword stlClassId   contained piecewise_linear_distribution
        syntax keyword stlClassId   contained poisson_distribution
        syntax keyword stlClassId   contained promise
        syntax keyword stlClassId   contained rank
        syntax keyword stlClassId   contained ratio
        syntax keyword stlClassId   contained ratio_add
        syntax keyword stlClassId   contained ratio_divide
        syntax keyword stlClassId   contained ratio_equal
        syntax keyword stlClassId   contained ratio_greater
        syntax keyword stlClassId   contained ratio_greater_equal
        syntax keyword stlClassId   contained ratio_less
        syntax keyword stlClassId   contained ratio_less_equal
        syntax keyword stlClassId   contained ratio_multiply
        syntax keyword stlClassId   contained ratio_not_equal
        syntax keyword stlClassId   contained ratio_subtract
        syntax keyword stlClassId   contained recursive_mutex
        syntax keyword stlClassId   contained recursive_timed_mutex
        syntax keyword stlClassId   contained remove_all_extents
        syntax keyword stlClassId   contained remove_const
        syntax keyword stlClassId   contained remove_cv
        syntax keyword stlClassId   contained remove_extent
        syntax keyword stlClassId   contained remove_pointer
        syntax keyword stlClassId   contained remove_reference
        syntax keyword stlClassId   contained remove_volatile
        syntax keyword stlClassId   contained result_of
        syntax keyword stlClassId   contained seed_seq
        syntax keyword stlClassId   contained shared_future
        syntax keyword stlClassId   contained shared_ptr
        syntax keyword stlClassId   contained shuffle_order_engine
        syntax keyword stlClassId   contained student_t_distribution
        syntax keyword stlClassId   contained subtract_with_carry_engine
        syntax keyword stlClassId   contained thread
        syntax keyword stlClassId   contained timed_mutex
        syntax keyword stlClassId   contained try_to_lock_t
        syntax keyword stlClassId   contained type_index
        syntax keyword stlClassId   contained underlying_type
        syntax keyword stlClassId   contained uniform_int_distribution
        syntax keyword stlClassId   contained uniform_real_distribution
        syntax keyword stlClassId   contained unique_lock
        syntax keyword stlClassId   contained unique_ptr
        syntax keyword stlClassId   contained unordered_map
        syntax keyword stlClassId   contained unordered_multimap
        syntax keyword stlClassId   contained unordered_multiset
        syntax keyword stlClassId   contained unordered_set
        syntax keyword stlClassId   contained weak_ptr
        syntax keyword stlClassId   contained weibull_distribution
        syntax match   stlClass     /std::\(add_\(const\|cv\|[lr]value_reference\|pointer\|volatile\)\|aligned_\(storage\|union\)\|alignment_of\|array\|adopt_lock_t\|common_type\|condition\(_variable\(_any\)\?\|al\)\|decay\|defer_lock_t\|enable_if\|extent\|forward_list\|future\|future_error\|has_virtual_destructor\|integral_constant\|lock_guard\|make_signed\|make_unsigned\|mutex\|once_flag\|packaged_task\|promise\|ratio\(_add\|_divide\|_equal\|_greater\(_equal\)\?\|_less\(_equal\)\?\|_multiply\|_not_equal\|_subtract\)\?\|rank\|recursive_mutex\|recursive_timed_mutex\|result_of\|seed_seq\|shared_future\|thread\(::id\)\?\|timed_mutex\|try_to_lock_t\|type_index\|underlying_type\|unique_lock\|unordered_map\|unordered_multimap\|unordered_multiset\|unordered_set\)\>/ contains=stlNamespaceId,stlClassId
        syntax match   stlClass     /std::\(bernoulli\|\(negative_\)\?binomial\|cauchy\|chi_squared\|discrete\|exponential\|extreme_value\|fisher_f\|gamma\|geometric\|\(log\)\?normal\|normal\|piecewise_\(constant\|linear\)\|poisson\|student_t\|uniform_\(int\|real\)\|weibull\)_distribution/ contains=stlNamespaceId,stlClassId
        syntax match   stlClass     /std::\(discard_block\|independent_bits\|linear_congruential\|mersenne_twister\|shuffle_order\|subtract_with_carry\)_engine/ contains=stlNamespaceId,stlClassId
        syntax match   stlClass     /std::\(shared_ptr\|unique_ptr\|weak_ptr\)/ contains=stlNamespaceId,stlClassId
        syntax match   stlClass     /std::is_\(abstract\|arithmetic\|array\|assignable\|base_of\|class\|compound\|const\|constructible\|convertible\|copy_assignable\|copy_constructible\|default_constructible\|destructible\|empty\|enum\|floating_point\|function\|fundamental\|integral\|literal_type\|lvalue_reference\|member_function_pointer\|member_object_pointer\|member_pointer\|move_assignable\|move_constructible\|nothrow_assignable\|nothrow_constructible\|nothrow_copy_assignable\|nothrow_copy_constructible\|nothrow_default_constructible\|nothrow_destructible\|nothrow_move_assignable\|nothrow_move_constructible\|object\|pod\|pointer\|polymorphic\|reference\|rvalue_reference\|same\|scalar\|signed\|standard_layout\|trivial\|union\|unsigned\|void\|volatile\)/ contains=stlNamespaceId,stlClassId
        syntax match   stlClass     /\<std::remove_\(all_extents\|const\|cv\|extent\|pointer\|reference\|volatile\)\>/ contains=stlNamespaceId,stlClassId
        endif
        "}}}

    " added in C++14 {{{
    if !exists('cpp_no_cpp14')
        syntax keyword stlClassId   contained is_final
        syntax keyword stlClassId   contained is_null_pointer
        syntax keyword stlClassId   contained shared_lock shared_timed_mutex
        syntax match   stlClass     /\<std::\(is_\(final\|null_pointer\)\|shared_\(lock\|timed_mutex\)\)\>/ contains=stlNamespaceId,stlClassId
    endif
    "}}}
" }}}

" constants {{{
    " all versions {{{
    syntax keyword stlConstantId    contained __STDC_UTF_16__
    syntax keyword stlConstantId    contained __STDC_UTF_32__
    syntax keyword stlConstantId    contained digits
    syntax keyword stlConstantId    contained digits10
    syntax keyword stlConstantId    contained has_denorm
    syntax keyword stlConstantId    contained has_denorm_loss
    syntax keyword stlConstantId    contained has_infinity
    syntax keyword stlConstantId    contained has_quiet_NaN
    syntax keyword stlConstantId    contained has_signaling_NaN
    syntax keyword stlConstantId    contained is_bounded
    syntax keyword stlConstantId    contained is_exact
    syntax keyword stlConstantId    contained is_iec559
    syntax keyword stlConstantId    contained is_integer
    syntax keyword stlConstantId    contained is_modulo
    syntax keyword stlConstantId    contained is_signed
    syntax keyword stlConstantId    contained is_specialized
    syntax keyword stlConstantId    contained max_exponent
    syntax keyword stlConstantId    contained max_exponent10
    syntax keyword stlConstantId    contained min_exponent
    syntax keyword stlConstantId    contained min_exponent10
    syntax keyword stlConstantId    contained nothrow
    syntax keyword stlConstantId    contained npos
    syntax keyword stlConstantId    contained MB_CUR_MAX
    syntax keyword stlConstantId    contained MB_LEN_MAX
    syntax keyword stlConstantId    contained HUGE_VAL
    syntax keyword stlConstantId    contained radix
    syntax keyword stlConstantId    contained RAND_MAX
    syntax keyword stlConstantId    contained round_style
    syntax keyword stlConstantId    contained tinyness_before
    syntax keyword stlConstantId    contained traps
    syntax keyword stlConstantId    contained WCHAR_MAX
    syntax keyword stlConstantId    contained WCHAR_MIN
    syntax keyword stlConstantId    contained WEOF
    syntax match   stlConstant      /std::\(__STDC_UTF_\(16\|32\)__\|MB_\(CUR\|LEN\)_MAX\|HUGE_VAL\|nothrow\|RAND_MAX\|WCHAR_M\(AX\|IN\)\|WEOF\)\>/ contains=stlNamespaceId,stlConstantId
    syntax match   stlConstant      /::npos/ contains=stlConstantId
    syntax match   stlConstant      /\<std::numeric_limits<.*>::\(digits\(10\)\?\|has_\(denorm\(_loss\)\?\|infinity\|\(quiet\|signaling\)_NaN\)\|is_\(bounded\|exact\|iec559\|integer\|modulo\|signed\|specialized\)\|\(max\|min\)_exponent\(10\)\?\|radix\|round_style\|tinyness_before\|traps\)\>/ contains=stlNamespaceId,stlClassId,stlConstantId,cType,cppType
    " }}}

    if !exists('cpp_no_cpp11') " {{{
        syntax keyword stlConstantId    contained adopt_lock
        syntax keyword stlConstantId    contained block_size
        syntax keyword stlConstantId    contained default_seed
        syntax keyword stlConstantId    contained defer_lock
        syntax keyword stlConstantId    contained den
        syntax keyword stlConstantId    contained FE_ALL_EXCEPT
        syntax keyword stlConstantId    contained FE_DFL_ENV
        syntax keyword stlConstantId    contained FE_DIVBYZERO
        syntax keyword stlConstantId    contained FE_DOWNWARD
        syntax keyword stlConstantId    contained FE_INEXACT
        syntax keyword stlConstantId    contained FE_INVALID
        syntax keyword stlConstantId    contained FE_OVERFLOW
        syntax keyword stlConstantId    contained FE_TONEAREST
        syntax keyword stlConstantId    contained FE_TOWARDZERO
        syntax keyword stlConstantId    contained FE_UNDERFLOW
        syntax keyword stlConstantId    contained FE_UPWARD
        syntax keyword stlConstantId    contained FP_INFINITE
        syntax keyword stlConstantId    contained FP_NAN
        syntax keyword stlConstantId    contained FP_NORMAL
        syntax keyword stlConstantId    contained FP_SUBNORMAL
        syntax keyword stlConstantId    contained FP_ZERO
        syntax keyword stlConstantId    contained HUGE_VALF
        syntax keyword stlConstantId    contained HUGE_VALL
        syntax keyword stlConstantId    contained increment
        syntax keyword stlConstantId    contained INFINITY
        syntax keyword stlConstantId    contained initialization_multiplier
        syntax keyword stlConstantId    contained long_lag
        syntax keyword stlConstantId    contained mask_bits
        syntax keyword stlConstantId    contained MATH_ERREXCEPT
        syntax keyword stlConstantId    contained math_errhandling
        syntax keyword stlConstantId    contained MATH_ERRNO
        syntax keyword stlConstantId    contained max_digits10
        syntax keyword stlConstantId    contained modulus
        syntax keyword stlConstantId    contained multiplier
        syntax keyword stlConstantId    contained NAN
        syntax keyword stlConstantId    contained num
        syntax keyword stlConstantId    contained shift_size
        syntax keyword stlConstantId    contained short_lag
        syntax keyword stlConstantId    contained state_size
        syntax keyword stlConstantId    contained table_size
        syntax keyword stlConstantId    contained tempering_b
        syntax keyword stlConstantId    contained tempering_c
        syntax keyword stlConstantId    contained tempering_d
        syntax keyword stlConstantId    contained tempering_l
        syntax keyword stlConstantId    contained tempering_s
        syntax keyword stlConstantId    contained tempering_t
        syntax keyword stlConstantId    contained tempering_u
        syntax keyword stlConstantId    contained try_to_lock
        syntax keyword stlConstantId    contained used_size
        syntax keyword stlConstantId    contained value
        syntax keyword stlConstantId    contained word_size
        syntax keyword stlConstantId    contained xor_mask
        syntax match   stlConstant      /std::\(adopt_lock\|defer_lock\|FP_\(INFINITE\|NAN\|NORMAL\|SUBNORMAL\|ZERO\)\|HUGE_VAL[FL]\|INFINITY\|MATH_ERR\(EXCEPT\|NO\)\|math_errhandling\|NAN\|try_to_lock\)\>/ contains=stlNamespaceId,stlConstantId
        syntax match   stlConstant      /std::discard_block_engine::\(block\|used\)_size/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /std::linear_congruential_engine::\(default_seed\|increment\|modulus\|multiplier\)/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /std::mersenne_twister_engine::\(default_seed\|initialization_multiplier\|mask_bits\|\(shift\|state\|word\)_size\|tempering_[bcdlstu]\|xor_mask\)/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /std::shuffle_order_engine::table_size/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /std::subtract_with_carry_engine::\(default_seed\|\(long\|short\)_lag\|word_size\)/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /std::FE_\(ALL_EXCEPT\|DFL_ENV\|DIVBYZERO\|DOWNWARD\|INEXACT\|INVALID\|OVERFLOW\|TONEAREST\|TOWARDZERO\|UNDERFLOW\|UPWARD\)/ contains=stlNamespaceId,stlConstantId
        syntax match   stlConstant      /std::ratio\(_add\|_divide\|_multiply\|_subtract\)\?::\(den\|num\)/ contains=stlNamespaceId,stlClassId,stlConstantId
        syntax match   stlConstant      /::\(max_digits10\|value\)\>/ contains=stlConstantId
    endif
    " }}}
" }}}

" data members {{{
if exists('stl_highlight_members')
    " TODO why does compare(comp); highlight the comp identifier?
    syntax keyword stlMemberId  contained c comp
    syntax match   stlMember    /\(\.\|->\)c\(omp\)\?/ contains=stlMemberId
endif
" }}}

" enumerations {{{
if !exists('cpp_no_cpp11')
    syntax keyword stlEnumerationId contained cv_status
    syntax keyword stlEnumerationId contained float_round_style
    syntax keyword stlEnumerationId contained float_denorm_style
    syntax keyword stlEnumerationId contained future_errc
    syntax keyword stlEnumerationId contained future_status
    syntax keyword stlEnumerationId contained launch
    syntax keyword stlEnumeratorId  contained async
    syntax keyword stlEnumeratorId  contained broken_promise
    syntax keyword stlEnumeratorId  contained deferred
    syntax keyword stlEnumeratorId  contained denorm_absent
    syntax keyword stlEnumeratorId  contained denorm_indeterminate
    syntax keyword stlEnumeratorId  contained denorm_present
    syntax keyword stlEnumeratorId  contained future_already_retrieved
    syntax keyword stlEnumeratorId  contained no_state
    syntax keyword stlEnumeratorId  contained no_timeout
    syntax keyword stlEnumeratorId  contained promise_already_satisfied
    syntax keyword stlEnumeratorId  contained ready
    syntax keyword stlEnumeratorId  contained round_indeterminate
    syntax keyword stlEnumeratorId  contained round_to_nearest
    syntax keyword stlEnumeratorId  contained round_toward_infinity
    syntax keyword stlEnumeratorId  contained round_toward_neg_infinity
    syntax keyword stlEnumeratorId  contained round_toward_zero
    syntax keyword stlEnumeratorId  contained timeout
    syntax match   stlEnumeration   /std::cv_status\(::no_timeout\|::timeout\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
    syntax match   stlEnumeration   /std::future_errc\(::broken_promise\|::future_already_retrieved\|::promise_already_satisfied\|::no_state\)\?\>/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
    syntax match   stlEnumeration   /std::future_status\(::deferred\|::ready\|::timeout\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
    syntax match   stlEnumeration   /std::launch\(::async\|::deferred\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
    syntax match   stlEnumeration   /\<std::float_\(round\|denorm\)_style\>/ contains=stlNamespaceId,stlEnumerationId
    syntax match   stlEnumerator    /\<std::\(denorm_\(absent\|indeterminate\|present\)\|round_\(indeterminate\|to_nearest\|toward_\(\(neg_\)\?infinity\|zero\)\)\)\>/ contains=stlNamespaceId,stlEnumeratorId
endif
" }}}

" free & static functions {{{
    " all versions {{{
    syntax keyword stlFunctionId    contained abs
    syntax keyword stlFunctionId    contained accumulate
    syntax keyword stlFunctionId    contained acos
    syntax keyword stlFunctionId    contained adjacent_difference
    syntax keyword stlFunctionId    contained adjacent_find
    syntax keyword stlFunctionId    contained arg
    syntax keyword stlFunctionId    contained asin
    syntax keyword stlFunctionId    contained atan
    syntax keyword stlFunctionId    contained atan2
    syntax keyword stlFunctionId    contained atof
    syntax keyword stlFunctionId    contained atoi
    syntax keyword stlFunctionId    contained atol
    syntax keyword stlFunctionId    contained atoll
    syntax keyword stlFunctionId    contained binary_search
    syntax keyword stlFunctionId    contained bsearch
    syntax keyword stlFunctionId    contained btowc
    syntax keyword stlFunctionId    contained calloc
    syntax keyword stlFunctionId    contained ceil
    syntax keyword stlFunctionId    contained conj
    syntax keyword stlFunctionId    contained copy
    syntax keyword stlFunctionId    contained copy_backward
    syntax keyword stlFunctionId    contained cos
    syntax keyword stlFunctionId    contained cosh
    syntax keyword stlFunctionId    contained count
    syntax keyword stlFunctionId    contained count_if
    syntax keyword stlFunctionId    contained denorm_min
    syntax keyword stlFunctionId    contained div
    syntax keyword stlFunctionId    contained eof
    syntax keyword stlFunctionId    contained epsilon
    syntax keyword stlFunctionId    contained eq
    syntax keyword stlFunctionId    contained eq_int_type
    syntax keyword stlFunctionId    contained equal
    syntax keyword stlFunctionId    contained equal_range
    syntax keyword stlFunctionId    contained exp
    syntax keyword stlFunctionId    contained fabs
    syntax keyword stlFunctionId    contained fill
    syntax keyword stlFunctionId    contained fill_n
    syntax keyword stlFunctionId    contained find
    syntax keyword stlFunctionId    contained find_end
    syntax keyword stlFunctionId    contained find_first_of
    syntax keyword stlFunctionId    contained find_if
    syntax keyword stlFunctionId    contained floor
    syntax keyword stlFunctionId    contained fmod
    syntax keyword stlFunctionId    contained for_each
    syntax keyword stlFunctionId    contained free
    syntax keyword stlFunctionId    contained frexp
    syntax keyword stlFunctionId    contained generate
    syntax keyword stlFunctionId    contained generate_n
    syntax keyword stlFunctionId    contained get_temporary_buffer
    syntax keyword stlFunctionId    contained imag
    syntax keyword stlFunctionId    contained includes
    syntax keyword stlFunctionId    contained infinity
    syntax keyword stlFunctionId    contained inner_product
    syntax keyword stlFunctionId    contained inplace_merge
    syntax keyword stlFunctionId    contained isalnum
    syntax keyword stlFunctionId    contained isalpha
    syntax keyword stlFunctionId    contained iscntrl
    syntax keyword stlFunctionId    contained isdigit
    syntax keyword stlFunctionId    contained isgraph
    syntax keyword stlFunctionId    contained islower
    syntax keyword stlFunctionId    contained isprint
    syntax keyword stlFunctionId    contained ispunct
    syntax keyword stlFunctionId    contained isspace
    syntax keyword stlFunctionId    contained isupper
    syntax keyword stlFunctionId    contained iswalnum
    syntax keyword stlFunctionId    contained iswalpha
    syntax keyword stlFunctionId    contained iswcntrl
    syntax keyword stlFunctionId    contained iswctype
    syntax keyword stlFunctionId    contained iswdigit
    syntax keyword stlFunctionId    contained iswgraph
    syntax keyword stlFunctionId    contained iswlower
    syntax keyword stlFunctionId    contained iswprint
    syntax keyword stlFunctionId    contained iswpunct
    syntax keyword stlFunctionId    contained iswspace
    syntax keyword stlFunctionId    contained iswupper
    syntax keyword stlFunctionId    contained iswxdigit
    syntax keyword stlFunctionId    contained isxdigit
    syntax keyword stlFunctionId    contained iter_swap
    syntax keyword stlFunctionId    contained labs
    syntax keyword stlFunctionId    contained ldexp
    syntax keyword stlFunctionId    contained ldiv
    syntax keyword stlFunctionId    contained lexicographical_compare
    syntax keyword stlFunctionId    contained log
    syntax keyword stlFunctionId    contained log10
    syntax keyword stlFunctionId    contained lower_bound
    syntax keyword stlFunctionId    contained lt
    syntax keyword stlFunctionId    contained malloc
    syntax keyword stlFunctionId    contained max
    syntax keyword stlFunctionId    contained max_element
    syntax keyword stlFunctionId    contained make_heap
    syntax keyword stlFunctionId    contained mblen
    syntax keyword stlFunctionId    contained mbrlen
    syntax keyword stlFunctionId    contained mbrtowc
    syntax keyword stlFunctionId    contained mbsinit
    syntax keyword stlFunctionId    contained mbsrtowcs
    syntax keyword stlFunctionId    contained mbstowcs
    syntax keyword stlFunctionId    contained mbtowc
    syntax keyword stlFunctionId    contained memchr
    syntax keyword stlFunctionId    contained memcmp
    syntax keyword stlFunctionId    contained memcpy
    syntax keyword stlFunctionId    contained memmove
    syntax keyword stlFunctionId    contained memset
    syntax keyword stlFunctionId    contained merge
    syntax keyword stlFunctionId    contained min
    syntax keyword stlFunctionId    contained min_element
    syntax keyword stlFunctionId    contained mismatch
    syntax keyword stlFunctionId    contained modf
    syntax keyword stlFunctionId    contained move
    syntax keyword stlFunctionId    contained next_permutation
    syntax keyword stlFunctionId    contained norm
    syntax keyword stlFunctionId    contained not_eof
    syntax keyword stlFunctionId    contained nth_element
    syntax keyword stlFunctionId    contained partial_sort
    syntax keyword stlFunctionId    contained partial_sort_copy
    syntax keyword stlFunctionId    contained partial_sum
    syntax keyword stlFunctionId    contained partition
    syntax keyword stlFunctionId    contained polar
    syntax keyword stlFunctionId    contained pop_heap
    syntax keyword stlFunctionId    contained pow
    syntax keyword stlFunctionId    contained prev_permutation
    syntax keyword stlFunctionId    contained push_heap
    syntax keyword stlFunctionId    contained qsort
    syntax keyword stlFunctionId    contained quiet_NaN
    syntax keyword stlFunctionId    contained rand
    syntax keyword stlFunctionId    contained real
    syntax keyword stlFunctionId    contained realloc
    syntax keyword stlFunctionId    contained remove
    syntax keyword stlFunctionId    contained remove_copy
    syntax keyword stlFunctionId    contained remove_copy_if
    syntax keyword stlFunctionId    contained remove_if
    syntax keyword stlFunctionId    contained replace
    syntax keyword stlFunctionId    contained replace_copy
    syntax keyword stlFunctionId    contained replace_copy_if
    syntax keyword stlFunctionId    contained replace_if
    syntax keyword stlFunctionId    contained return_temporary_buffer
    syntax keyword stlFunctionId    contained reverse
    syntax keyword stlFunctionId    contained reverse_copy
    syntax keyword stlFunctionId    contained rotate
    syntax keyword stlFunctionId    contained rotate_copy
    syntax keyword stlFunctionId    contained round_error
    syntax keyword stlFunctionId    contained search
    syntax keyword stlFunctionId    contained search_n
    syntax keyword stlFunctionId    contained set_difference
    syntax keyword stlFunctionId    contained set_intersection
    syntax keyword stlFunctionId    contained set_new_handler
    syntax keyword stlFunctionId    contained set_symmetric_difference
    syntax keyword stlFunctionId    contained set_union
    syntax keyword stlFunctionId    contained signaling_NaN
    syntax keyword stlFunctionId    contained sin
    syntax keyword stlFunctionId    contained sinh
    syntax keyword stlFunctionId    contained sort
    syntax keyword stlFunctionId    contained sort_heap
    syntax keyword stlFunctionId    contained sqrt
    syntax keyword stlFunctionId    contained srand
    syntax keyword stlFunctionId    contained stable_partition
    syntax keyword stlFunctionId    contained stable_sort
    syntax keyword stlFunctionId    contained stod
    syntax keyword stlFunctionId    contained stof
    syntax keyword stlFunctionId    contained stoi
    syntax keyword stlFunctionId    contained stol
    syntax keyword stlFunctionId    contained stoll
    syntax keyword stlFunctionId    contained stoul
    syntax keyword stlFunctionId    contained stold
    syntax keyword stlFunctionId    contained stoull
    syntax keyword stlFunctionId    contained strcat
    syntax keyword stlFunctionId    contained strchr
    syntax keyword stlFunctionId    contained strcmp
    syntax keyword stlFunctionId    contained strcoll
    syntax keyword stlFunctionId    contained strcpy
    syntax keyword stlFunctionId    contained strcspn
    syntax keyword stlFunctionId    contained strerror
    syntax keyword stlFunctionId    contained strlen
    syntax keyword stlFunctionId    contained strncat
    syntax keyword stlFunctionId    contained strncmp
    syntax keyword stlFunctionId    contained strncpy
    syntax keyword stlFunctionId    contained strpbrk
    syntax keyword stlFunctionId    contained strrchr
    syntax keyword stlFunctionId    contained strspn
    syntax keyword stlFunctionId    contained strstr
    syntax keyword stlFunctionId    contained strtod
    syntax keyword stlFunctionId    contained strtof
    syntax keyword stlFunctionId    contained strtok
    syntax keyword stlFunctionId    contained strtol
    syntax keyword stlFunctionId    contained strtold
    syntax keyword stlFunctionId    contained strtoll
    syntax keyword stlFunctionId    contained strtoul
    syntax keyword stlFunctionId    contained strtoull
    syntax keyword stlFunctionId    contained strxfrm
    syntax keyword stlFunctionId    contained swap
    syntax keyword stlFunctionId    contained swap_ranges
    syntax keyword stlFunctionId    contained tan
    syntax keyword stlFunctionId    contained tanh
    syntax keyword stlFunctionId    contained to_char_type
    syntax keyword stlFunctionId    contained to_int_type
    syntax keyword stlFunctionId    contained to_string
    syntax keyword stlFunctionId    contained to_wstring
    syntax keyword stlFunctionId    contained tolower
    syntax keyword stlFunctionId    contained toupper
    syntax keyword stlFunctionId    contained towctrans
    syntax keyword stlFunctionId    contained towlower
    syntax keyword stlFunctionId    contained towupper
    syntax keyword stlFunctionId    contained transform
    syntax keyword stlFunctionId    contained uninitialized_copy
    syntax keyword stlFunctionId    contained uninitialized_fill
    syntax keyword stlFunctionId    contained uninitialized_fill_n
    syntax keyword stlFunctionId    contained unique
    syntax keyword stlFunctionId    contained unique_copy
    syntax keyword stlFunctionId    contained upper_bound
    syntax keyword stlFunctionId    contained wcrtomb
    syntax keyword stlFunctionId    contained wcscat
    syntax keyword stlFunctionId    contained wcschr
    syntax keyword stlFunctionId    contained wcscmp
    syntax keyword stlFunctionId    contained wcscoll
    syntax keyword stlFunctionId    contained wcscpy
    syntax keyword stlFunctionId    contained wcscspn
    syntax keyword stlFunctionId    contained wcslen
    syntax keyword stlFunctionId    contained wcsncat
    syntax keyword stlFunctionId    contained wcsncmp
    syntax keyword stlFunctionId    contained wcsncpy
    syntax keyword stlFunctionId    contained wcspbrk
    syntax keyword stlFunctionId    contained wcsrchr
    syntax keyword stlFunctionId    contained wcsrtombs
    syntax keyword stlFunctionId    contained wcsspn
    syntax keyword stlFunctionId    contained wcsstr
    syntax keyword stlFunctionId    contained wcstod
    syntax keyword stlFunctionId    contained wcstof
    syntax keyword stlFunctionId    contained wcstok
    syntax keyword stlFunctionId    contained wcstol
    syntax keyword stlFunctionId    contained wcstold
    syntax keyword stlFunctionId    contained wcstoll
    syntax keyword stlFunctionId    contained wcstombs
    syntax keyword stlFunctionId    contained wcstoul
    syntax keyword stlFunctionId    contained wcstoull
    syntax keyword stlFunctionId    contained wcsxfrm
    syntax keyword stlFunctionId    contained wctob
    syntax keyword stlFunctionId    contained wctomb
    syntax keyword stlFunctionId    contained wctrans
    syntax keyword stlFunctionId    contained wctype
    syntax keyword stlFunctionId    contained wmemchr
    syntax keyword stlFunctionId    contained wmemcmp
    syntax keyword stlFunctionId    contained wmemcpy
    syntax keyword stlFunctionId    contained wmemmove
    syntax keyword stlFunctionId    contained wmemset
    syntax match   stlFunction      /std::\(btowc\|mb\(len\|rlen\|rtowc\|sinit\|srtowcs\|stowcs\|towc\)\|wc\(rtomb\|srtombs\|stombs\|tob\|tomb\)\)\>/ contains=stlNamespaceId,stlFunctionId
    syntax match   stlFunction      /std::wc\(s\(cat\|chr\|cmp\|coll\|cpy\|cspn\|len\|ncat\|ncmp\|ncpy\|pbrk\|rchr\|rtombs\|spn\|str\|tod\|tof\|tok\|tol\|told\|toll\|tombs\|toul\|toull\|xfrm\)\|trans\|type\)\>/ contains=stlNamespaceId,stlFunctionId
    syntax match   stlFunction      /std::\(abs\|accumulate\|acos\|adjacent_difference\|adjacent_find\|alloc\|arg\|asin\|atan2\?\|ato\(f\|i\|l\|ll\)\|binary_search\|bsearch\|calloc\|ceil\|conj\|copy\|copy_backward\|cosh\?\|count\|count_if\|div\|equal\|equal_range\|exp\|fabs\|fill\|fill_n\|find\|find_end\|find_first_of\|find_if\|floor\|fmod\|for_each\|free\|frexp\|generate\|generate_n\|get_temporary_buffer\|imag\|includes\|inner_product\|inplace_merge\|isw\?\(alnum\|alpha\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\)\|iswctype\|iter_swap\|labs\|ldexp\|ldiv\|lexicographical_compare\|log\|log10\|lower_bound\|malloc\|max\|max_element\|make_heap\|w\?mem\(chr\|cmp\|cpy\|move\|set\)\|merge\|min\|min_element\|mismatch\|modf\|next_permutation\|norm\|nth_element\|partial_sort\|partial_sort_copy\|partial_sum\|partition\|polar\|pop_heap\|pow\|prev_permutation\|push_heap\|qsort\|real\|realloc\|remove\|remove_copy\|remove_copy_if\|remove_if\|replace\|replace_copy\|replace_copy_if\|replace_if\|return_temporary_buffer\|reverse\|reverse_copy\|rotate\|rotate_copy\|search\|search_n\|set_difference\|set_intersection\|set_new_handler\|set_symmetric_difference\|set_union\|sinh\?\|sort\|sort_heap\|sqrt\|s\?rand\|stable_partition\|stable_sort\|sto\(i\|l\|ll\|ul\|ull\|f\|d\|ld\)\|str\(cat\|chr\|cmp\|coll\|cpy\|cspn\|error\|len\|ncat\|ncmp\|ncpy\|pbrk\|rchr\|spn\|str\|to\(d\|f\|k\|l\|ld\|ll\|ul\|ull\)\|xfrm\)\|swap\|swap_ranges\|tanh\?\|to\(_string\|_wstring\|wctrans\|w\?lower\|w\?upper\)\|transform\|uninitialized_\(copy\|fill\|fill_n\)\|unique\|unique_copy\|upper_bound\|\)\>/ contains=stlNamespaceId,stlFunctionId
    syntax match   stlFunction      /::\(assign\|compare\|copy\|eof\|eq\|eq_int_type\|find\|length\|lt\|move\|not_eof\|to_char_type\|to_int_type\)\>/ contains=stlMethodId,stlFunctionId
    syntax match   stlFunction      /\<std::numeric_limits<.*>::\(\(denorm_\)\?min\|epsilon\|infinity\|max\|\(quiet\|signaling\)_NaN\|round_error\)\>/ contains=stlNamespaceId,stlClassId,stlFunctionId,cType,cppType
    " }}}

    " C++11 {{{
    if !exists('cpp_no_cpp11')
        syntax keyword stlFunctionId    contained acosh
        syntax keyword stlFunctionId    contained all_of
        syntax keyword stlFunctionId    contained allocate_shared
        syntax keyword stlFunctionId    contained any_of
        syntax keyword stlFunctionId    contained asinh
        syntax keyword stlFunctionId    contained async
        syntax keyword stlFunctionId    contained atanh
        syntax keyword stlFunctionid    contained atomic_is_lock_free
        syntax keyword stlFunctionid    contained atomic_load
        syntax keyword stlFunctionid    contained atomic_load_explicit
        syntax keyword stlFunctionid    contained atomic_store
        syntax keyword stlFunctionid    contained atomic_store_explicit
        syntax keyword stlFunctionid    contained atomic_exchange
        syntax keyword stlFunctionid    contained atomic_exchange_explicit
        syntax keyword stlFunctionid    contained atomic_compare_exchange_weak
        syntax keyword stlFunctionid    contained atomic_compare_exchange_strong
        syntax keyword stlFunctionid    contained atomic_compare_exchange_weak_explicit
        syntax keyword stlFunctionid    contained atomic_compare_exchange_strong_explicit
        syntax keyword stlFunctionId    contained c16rtomb
        syntax keyword stlFunctionId    contained c32rtomb
        syntax keyword stlFunctionId    contained call_once
        syntax keyword stlFunctionId    contained cbrt
        syntax keyword stlFunctionId    contained copy_if
        syntax keyword stlFunctionId    contained copy_n
        syntax keyword stlFunctionId    contained copysign
        syntax keyword stlFunctionId    contained erf
        syntax keyword stlFunctionId    contained erfc
        syntax keyword stlFunctionId    contained exp2
        syntax keyword stlFunctionId    contained expm1
        syntax keyword stlFunctionId    contained fdim
        syntax keyword stlFunctionId    contained feclearexcept
        syntax keyword stlFunctionId    contained fegetenv
        syntax keyword stlFunctionId    contained fegetexceptflag
        syntax keyword stlFunctionId    contained fegetround
        syntax keyword stlFunctionId    contained feholdexcept
        syntax keyword stlFunctionId    contained feraiseexcept
        syntax keyword stlFunctionId    contained fesetenv
        syntax keyword stlFunctionId    contained fesetexceptflag
        syntax keyword stlFunctionId    contained fesetround
        syntax keyword stlFunctionId    contained fetestexcept
        syntax keyword stlFunctionId    contained feupdateenv
        syntax keyword stlFunctionId    contained find_if_not
        syntax keyword stlFunctionId    contained fma
        syntax keyword stlFunctionId    contained fmax
        syntax keyword stlFunctionId    contained fmin
        syntax keyword stlFunctionId    contained fpclassify
        syntax keyword stlFunctionId    contained future_category
        syntax keyword stlFunctionId    contained generate_canonical
        syntax keyword stlFunctionId    contained get
        syntax keyword stlFunctionId    contained get_id
        syntax keyword stlFunctionId    contained hardware_concurrency
        syntax keyword stlFunctionId    contained hash
        syntax keyword stlFunctionId    contained hypot
        syntax keyword stlFunctionId    contained ilogb
        syntax keyword stlFunctionId    contained imaxabs
        syntax keyword stlFunctionId    contained imaxdiv
        syntax keyword stlFunctionId    contained iota
        syntax keyword stlFunctionId    contained is_heap
        syntax keyword stlFunctionId    contained is_heap_until
        syntax keyword stlFunctionId    contained is_partitioned
        syntax keyword stlFunctionId    contained is_permutation
        syntax keyword stlFunctionId    contained is_sorted
        syntax keyword stlFunctionId    contained is_sorted_until
        syntax keyword stlFunctionId    contained isblank
        syntax keyword stlFunctionId    contained isfinite
        syntax keyword stlFunctionId    contained isgreater
        syntax keyword stlFunctionId    contained isgreaterequal
        syntax keyword stlFunctionId    contained isinf
        syntax keyword stlFunctionId    contained isless
        syntax keyword stlFunctionId    contained islessequal
        syntax keyword stlFunctionId    contained islessgreater
        syntax keyword stlFunctionId    contained isnan
        syntax keyword stlFunctionId    contained isnormal
        syntax keyword stlFunctionId    contained isunordered
        syntax keyword stlFunctionId    contained iswblank
        syntax keyword stlFunctionId    contained lgamma
        syntax keyword stlFunctionId    contained llabs
        syntax keyword stlFunctionId    contained lldiv
        syntax keyword stlFunctionId    contained llrint
        syntax keyword stlFunctionId    contained llround
        syntax keyword stlFunctionId    contained lock
        syntax keyword stlFunctionId    contained log1p
        syntax keyword stlFunctionId    contained log2
        syntax keyword stlFunctionId    contained logb
        syntax keyword stlFunctionId    contained lowest
        syntax keyword stlFunctionId    contained lrint
        syntax keyword stlFunctionId    contained lround
        syntax keyword stlFunctionId    contained make_error_code
        syntax keyword stlFunctionId    contained make_error_condition
        syntax keyword stlFunctionId    contained get_deleter
        syntax keyword stlFunctionId    contained make_shared
        syntax keyword stlFunctionId    contained static_pointer_cast
        syntax keyword stlFunctionId    contained dynamic_pointer_cast
        syntax keyword stlFunctionId    contained const_pointer_cast
        syntax keyword stlFunctionId    contained mbrtoc16
        syntax keyword stlFunctionId    contained mbrtoc32
        syntax keyword stlFunctionId    contained minmax
        syntax keyword stlFunctionId    contained minmax_element
        syntax keyword stlFunctionId    contained move
        syntax keyword stlFunctionId    contained move_backward
        syntax keyword stlFunctionId    contained nan
        syntax keyword stlFunctionId    contained nanf
        syntax keyword stlFunctionId    contained nanl
        syntax keyword stlFunctionId    contained nearbyint
        syntax keyword stlFunctionId    contained nextafter
        syntax keyword stlFunctionId    contained nexttoward
        syntax keyword stlFunctionId    contained none_of
        syntax keyword stlFunctionId    contained notify_all_at_thread_exit
        syntax keyword stlFunctionId    contained partition_copy
        syntax keyword stlFunctionId    contained partition_point
        syntax keyword stlFunctionId    contained proj
        syntax keyword stlFunctionId    contained remainder
        syntax keyword stlFunctionId    contained remquo
        syntax keyword stlFunctionId    contained rint
        syntax keyword stlFunctionId    contained round
        syntax keyword stlFunctionId    contained scalbn
        syntax keyword stlFunctionId    contained scalbln
        syntax keyword stlFunctionId    contained shuffle
        syntax keyword stlFunctionId    contained signbig
        syntax keyword stlFunctionId    contained sleep_for
        syntax keyword stlFunctionId    contained sleep_until
        syntax keyword stlFunctionId    contained strtoimax
        syntax keyword stlFunctionId    contained strtoumax
        syntax keyword stlFunctionId    contained swap
        syntax keyword stlFunctionId    contained tgamma
        syntax keyword stlFunctionId    contained trunc
        syntax keyword stlFunctionId    contained try_lock
        syntax keyword stlFunctionId    contained yield
        syntax keyword stlFunctionId    contained wcstoimax
        syntax keyword stlFunctionId    contained wcstoumax
        syntax match   stlFunction      /\<std::\(c\(16\|32\)rtomb\|mbrtoc\(16\|32\)\)\>/ contains=stlNamespaceId,stlFunctionId
        syntax match   stlFunction      /\<std::\(acosh\|all_of\|any_of\|asinh\|async\|atanh\|call_once\|cbrt\|copy_if\|copy_n\|copysign\|erfc\?\|exp2\|expm1\|fdim\|find_if_not\|fma\|fmax\|fmin\|fpclassify\|future_category\|generate_canonical\|get\|get_id\|hash\|hypot\|ilogb\|imaxabs\|imaxdiv\|iota\|is\(_heap\|_heap_until\|_partitioned\|_permutation\|_sorted\|_sorted_until\|finite\|greater\(equal\)\?\|inf\|less\(equal\|greater\)\?\|nan\|normal\|unordered\|w\?blank\)\|lgamma\|ll\(abs\|div\|rint\|round\)\|lock\|log\(1p\|2\|b\)\|lrint\|lround\|make_error_code\|make_error_condition\|minmax\|minmax_element\|move\|move_backward\|nan[fl]\?\|nearbyint\|next\(after\|toward\)\|none_of\|notify_all_at_thread_exit\|partition_copy\|partition_point\|proj\|remainder\|remquo\|rint\|round\|scalbl\?n\|shuffle\|signbig\|sleep_for\|sleep_until\|strto[iu]max\|swap\|tgamma\|trunc\|try_lock\|wcsto[iu]max\|yield\)\>/ contains=stlNamespaceId,stlFunctionId
        syntax match   stlFunction      /\<std::thread::hardware_concurrency/ contains=stlNamespaceId,stlClassId,stlFunctionId
        syntax match   stlFunction      /\<std::\(\(discard_block\|independent_bits\|linear_congruential\|mersenne_twister\|shuffle_order\|subtract_with_carry\)_engine\|random_device\)::m\(ax\|in\)\>/ contains=stlNamespaceId,stlClassId,stlFunctionId
        syntax match   stlFunction      /\<std::fe\(\(clear\|hold\|raise\|test\)except\|[gs]et\(env\|exceptflag\|round\)\|updateenv\)/ contains=stlNamespaceId,stlFunctionId
        syntax match   stlFunction      /\<std::atomic_\(is_lock_free\|load\|load_explicit\|store\|store_explicit\|exchange\|exchange_explicit\|compare_exchange_weak\|compare_exchange_strong\|compare_exchange_weak_explicit\|compare_exchange_strong_explicit\)\>/ contains=stlNamespaceId,stlFunctionId
        syntax match   stlFunction      /\<std::\(allocate_shared\|get_deleter\|make_shared\|\(static\|dynamic\|const\)_pointer_cast\)\>/ contains=stlNamespaceId,stlFunctionId
        syntax match   stlFunction      /::lowest\>/ contains=stlFunctionId
    endif
    " }}}

    " deprecated in C++14 {{{
    if exists('cpp_no_cpp14') && exists('cpp_no_cpp17')
        syntax keyword stlFunctionId    contained make_unique random_shuffle
        syntax match   stlFunction      /\<std::\(make_unique\|random_shuffle\)\>/ contains=stlNamespaceId,stlFunctionId
    endif
    " }}}

    " C++17
    "syntax keyword stlFunctionId    contained reinterpret_pointer_cast
" }}}

" macros {{{
    syntax keyword stlMacroFuncId   offsetof

    if !exists('cpp_no_cpp11') " {{{
        syntax keyword stlMacroConstId  __align_is_defined
                                    \   __bool_true_false_are_defined
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
                                    \   PRIdMAX PRIdPTR
                                    \   PRIiMAX PRIiPTR
                                    \   PRIuMAX PRIuPTR
                                    \   PRIoMAX PRIoPTR
                                    \   PRIxMAX PRIxPTR
                                    \   PRIXMAX PRIXPTR
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
                                    \   SCNdMAX SCNdPTR
                                    \   SCNiMAX SCNiPTR
                                    \   SCNuMAX SCNuPTR
                                    \   SCNoMAX SCNoPTR
                                    \   SCNxMAX SCNxPTR
                                    \   SCNXMAX SCNXPTR
        syntax keyword stlMacroFuncId   INT8_C
                                    \   INT16_C
                                    \   INT32_C
                                    \   INT64_C
                                    \   INTMAX_C
                                    \   UINT8_C
                                    \   UINT16_C
                                    \   UINT32_C
                                    \   UINT64_C
                                    \   UINTMAX_C
    endif
    " }}}
" }}}

" methods {{{
if exists('stl_highlight_members')
    " all versions {{{
    syntax keyword stlMethodId  contained address
    syntax keyword stlMethodId  contained allocate
    syntax keyword stlMethodId  contained append
    syntax keyword stlMethodId  contained apply
    syntax keyword stlMethodId  contained assign
    syntax keyword stlMethodId  contained at
    syntax keyword stlMethodId  contained back
    syntax keyword stlMethodId  contained before
    syntax keyword stlMethodId  contained begin
    syntax keyword stlMethodId  contained c_str
    syntax keyword stlMethodId  contained capacity
    syntax keyword stlMethodId  contained cbegin
    syntax keyword stlMethodId  contained cend
    syntax keyword stlMethodId  contained clear
    syntax keyword stlMethodId  contained compare
    syntax keyword stlMethodId  contained construct
    syntax keyword stlMethodId  contained copy
    syntax keyword stlMethodId  contained count
    syntax keyword stlMethodId  contained crbegin
    syntax keyword stlMethodId  contained crend
    syntax keyword stlMethodId  contained cshift
    syntax keyword stlMethodId  contained data
    syntax keyword stlMethodId  contained deallocate
    syntax keyword stlMethodId  contained destroy
    syntax keyword stlMethodId  contained empty
    syntax keyword stlMethodId  contained end
    syntax keyword stlMethodId  contained equal_range
    syntax keyword stlMethodId  contained erase
    syntax keyword stlMethodId  contained find
    syntax keyword stlMethodId  contained find_first_not_of
    syntax keyword stlMethodId  contained find_first_of
    syntax keyword stlMethodId  contained find_last_not_of
    syntax keyword stlMethodId  contained find_last_of
    syntax keyword stlMethodId  contained front
    syntax keyword stlMethodId  contained get_allocator
    syntax keyword stlMethodId  contained imag
    syntax keyword stlMethodId  contained insert
    syntax keyword stlMethodId  contained key_comp
    syntax keyword stlMethodId  contained length
    syntax keyword stlMethodId  contained lower_bound
    syntax keyword stlMethodId  contained max
    syntax keyword stlMethodId  contained max_size
    syntax keyword stlMethodId  contained merge
    syntax keyword stlMethodId  contained min
    syntax keyword stlMethodId  contained name
    syntax keyword stlMethodId  contained pop
    syntax keyword stlMethodId  contained pop_back
    syntax keyword stlMethodId  contained pop_front
    syntax keyword stlMethodId  contained push
    syntax keyword stlMethodId  contained push_back
    syntax keyword stlMethodId  contained push_front
    syntax keyword stlMethodId  contained rbegin
    syntax keyword stlMethodId  contained real
    syntax keyword stlMethodId  contained remove
    syntax keyword stlMethodId  contained remove_if
    syntax keyword stlMethodId  contained rend
    syntax keyword stlMethodId  contained replace
    syntax keyword stlMethodId  contained reserve
    syntax keyword stlMethodId  contained resize
    syntax keyword stlMethodId  contained reverse
    syntax keyword stlMethodId  contained rfind
    syntax keyword stlMethodId  contained shift
    syntax keyword stlMethodId  contained size
    syntax keyword stlMethodId  contained sort
    syntax keyword stlMethodId  contained splice
    syntax keyword stlMethodId  contained substr
    syntax keyword stlMethodId  contained sum
    syntax keyword stlMethodId  contained swap
    syntax keyword stlMethodId  contained top
    syntax keyword stlMethodId  contained unique
    syntax keyword stlMethodId  contained upper_bound
    syntax keyword stlMethodId  contained value_comp
    syntax match   stlMethod    /\(->\|\.\)\(address\|allocate\|append\|apply\|assign\|at\|back\|before\|begin\|c_str\|capacity\|cbegin\|cend\|clear\|compare\|construct\|copy\|count\|crbegin\|crend\|c\?shift\|data\|deallocate\|destroy\|empty\|end\|equal_range\|erase\|find\|find_first_not_of\|find_first_of\|find_last_not_of\|find_last_of\|front\|get_allocator\|imag\|insert\|key_comp\|length\|lower_bound\|max\(_size\)\?\|merge\|min\|name\|pop\|pop_back\|pop_front\|push\|push_back\|push_front\|rbegin\|real\|remove\|remove_if\|rend\|replace\|reserve\|resize\|reverse\|rfind\|size\|sort\|splice\|substr\|sum\|swap\|top\|unique\|upper_bound\|value_comp\)\>/ contains=stlMethodId
    "}}}

    if !exists('cpp_no_cpp11') " {{{
        syntax keyword stlMethodId  contained a
        syntax keyword stlMethodId  contained alpha
        syntax keyword stlMethodId  contained b
        syntax keyword stlMethodId  contained base
        syntax keyword stlMethodId  contained before_begin
        syntax keyword stlMethodId  contained beta
        syntax keyword stlMethodId  contained bucket
        syntax keyword stlMethodId  contained bucket_count
        syntax keyword stlMethodId  contained bucket_size
        syntax keyword stlMethodId  contained cbefore_begin
        syntax keyword stlMethodId  contained code
        syntax keyword stlMethodId  contained densities
        syntax keyword stlMethodId  contained detach
        syntax keyword stlMethodId  contained discard
        syntax keyword stlMethodId  contained emplace
        syntax keyword stlMethodId  contained emplace_after
        syntax keyword stlMethodId  contained emplace_back
        syntax keyword stlMethodId  contained emplace_front
        syntax keyword stlMethodId  contained emplace_hint
        syntax keyword stlMethodId  contained entropy
        syntax keyword stlMethodId  contained erase_after
        syntax keyword stlMethodId  contained expired
        syntax keyword stlMethodId  contained fill
        syntax keyword stlMethodId  contained get
        syntax keyword stlMethodId  contained get_deleter
        syntax keyword stlMethodId  contained get_future
        syntax keyword stlMethodId  contained get_id
        syntax keyword stlMethodId  contained hash_code
        syntax keyword stlMethodId  contained hash_function
        syntax keyword stlMethodId  contained insert_after
        syntax keyword stlMethodId  contained intervals
        syntax keyword stlMethodId  contained join
        syntax keyword stlMethodId  contained joinable
        syntax keyword stlMethodId  contained k
        syntax keyword stlMethodId  contained key_eq
        syntax keyword stlMethodId  contained lambda
        syntax keyword stlMethodId  contained load_factor
        syntax keyword stlMethodId  contained lock
        syntax keyword stlMethodId  contained m
        syntax keyword stlMethodId  contained max_bucket_count
        syntax keyword stlMethodId  contained max_load_factor
        syntax keyword stlMethodId  contained make_ready_at_thread_exit
        syntax keyword stlMethodId  contained mean
        syntax keyword stlMethodId  contained mutex
        syntax keyword stlMethodId  contained n
        syntax keyword stlMethodId  contained native_handle
        syntax keyword stlMethodId  contained notify_all
        syntax keyword stlMethodId  contained notify_one
        syntax keyword stlMethodId  contained owner_before
        syntax keyword stlMethodId  contained owns_lock
        syntax keyword stlMethodId  contained p
        syntax keyword stlMethodId  contained param
        syntax keyword stlMethodId  contained probabilities
        syntax keyword stlMethodId  contained rehash
        syntax keyword stlMethodId  contained release
        syntax keyword stlMethodId  contained reset
        syntax keyword stlMethodId  contained s
        syntax keyword stlMethodId  contained seed
        syntax keyword stlMethodId  contained set_exception
        syntax keyword stlMethodId  contained set_exception_at_thread_exit
        syntax keyword stlMethodId  contained set_value
        syntax keyword stlMethodId  contained set_value_at_thread_exit
        syntax keyword stlMethodId  contained share
        syntax keyword stlMethodId  contained shrink_to_fit
        syntax keyword stlMethodId  contained splice_after
        syntax keyword stlMethodId  contained stddev
        syntax keyword stlMethodId  contained t
        syntax keyword stlMethodId  contained try_lock
        syntax keyword stlMethodId  contained try_lock_for
        syntax keyword stlMethodId  contained try_lock_until
        syntax keyword stlMethodId  contained unique
        syntax keyword stlMethodId  contained unlock
        syntax keyword stlMethodId  contained use_count
        syntax keyword stlMethodId  contained valid
        syntax keyword stlMethodId  contained wait
        syntax keyword stlMethodId  contained wait_for
        syntax keyword stlMethodId  contained wait_until
        syntax keyword stlMethodId  contained what
        syntax match   stlMethod    /\(->\|\.\)\(a\|alpha\|b\|base\|before_begin\|beta\|bucket\|bucket_count\|bucket_size\|cbefore_begin\|code\|densities\|detach\|discard\|emplace\(_after\|_back\|_front\|_hint\)\?\|entropy\|erase_after\|expired\|fill\|get\|get_deleter\|get_future\|get_id\|hash_code\|hash_function\|insert_after\|intervals\|join\|joinable\|k\|key_eq\|lambda\|load_factor\|lock\|m\|make_ready_at_thread_exit\|max_bucket_count\|max_load_factor\|mean\|mutex\|n\|native_handle\|notify_all\|notify_one\|owner_before\|owns_lock\|p\|param\|probabilities\|rehash\|release\|reset\|s\|seed\|set_exception\|set_exception_at_thread_exit\|set_value\|set_value_at_thread_exit\|share\|shrink_to_fit\|splice_after\|stddev\|t\|try_lock\|try_lock_for\|try_lock_until\|unique\|unlock\|use_count\|valid\|wait\|wait_for\|wait_until\|what\)\>/ contains=stlMethodId
    endif
    " }}}

    if !exists('cpp_no_cpp14') " {{{
        syntax keyword stlMethodId  contained lock_shared
        syntax keyword stlMethodId  contained try_lock_shared
        syntax keyword stlMethodId  contained try_lock_shared_for
        syntax keyword stlMethodId  contained try_lock_shared_until
        syntax keyword stlMethodId  contained unlock_shared
        syntax match   stlMethod    /\(->\|\.\)\(lock_shared\|try_lock_shared\|try_lock_shared_for\|try_lock_shared_until\|unlock_shared\)\>/ contains=stlMethodId
    endif
    " }}}

    if !exists('cpp_no_cpp17') " {{{
        syntax keyword stlMethodId  contained insert_or_assign
        syntax keyword stlMethodId  contained try_emplace
        syntax match   stlMethod    /\(->\|\.\)\(insert_or_assign\|try_emplace\)\>/ contains=stlMethodId
    endif
    " }}}
endif
" }}}

" typedefs {{{
    " all versions {{{
    syntax keyword stlTypeId    contained allocator_type
    syntax keyword stlTypeId    contained char_type
    syntax keyword stlTypeId    contained const_iterator
    syntax keyword stlTypeId    contained const_pointer
    syntax keyword stlTypeId    contained const_reference
    syntax keyword stlTypeId    contained const_reverse_iterator
    syntax keyword stlTypeId    contained container_type
    syntax keyword stlTypeId    contained difference_type
    syntax keyword stlTypeId    contained div_t
    syntax keyword stlTypeId    contained fenv_t
    syntax keyword stlTypeId    contained fexcept_t
    syntax keyword stlTypeId    contained first_argument_type
    syntax keyword stlTypeId    contained int_type
    syntax keyword stlTypeId    contained iterator
    syntax keyword stlTypeId    contained key_compare
    syntax keyword stlTypeId    contained key_type
    syntax keyword stlTypeId    contained ldiv_t
    syntax keyword stlTypeId    contained mapped_type
    syntax keyword stlTypeId    contained off_type
    syntax keyword stlTypeId    contained new_handler
    syntax keyword stlTypeId    contained pointer
    syntax keyword stlTypeId    contained pos_type
    syntax keyword stlTypeId    contained ptrdiff_t
    syntax keyword stlTypeId    contained rebind
    syntax keyword stlTypeId    contained reference
    syntax keyword stlTypeId    contained result_type
    syntax keyword stlTypeId    contained reverse_iterator
    syntax keyword stlTypeId    contained second_argument_type
    syntax keyword stlTypeId    contained size_t
    syntax keyword stlTypeId    contained size_type
    syntax keyword stlTypeId    contained state_type
    syntax keyword stlTypeId    contained string
    syntax keyword stlTypeId    contained traits_type
    syntax keyword stlTypeId    contained value_type
    syntax keyword stlTypeId    contained u16string
    syntax keyword stlTypeId    contained u32string
    syntax keyword stlTypeId    contained wstring
    syntax match   stlType      /::\(allocator_type\|char_type\|const_iterator\|const_pointer\|const_reference\|const_reverse_iterator\|container_type\|difference_type\|int_type\|iterator\|key_compare\|key_type\|mapped_type\|off_type\|pointer\|pos_type\|rebind\|reference\|reverse_iterator\|size_type\|state_type\|traits_type\|value_type\)/ contains=stlTypeId
    syntax match   stlType      /::value_compare::\(first_argument_type\|result_type\|second_argument_type\)\>/ contains=stlClassId,stlTypeId
    syntax match   stlType      /std::\(fenv_t\|fexcept_t\|l\?div_t\|new_handler\|ptrdiff_t\|size_t\|\(u16\|u32\|w\)\?string\)/ contains=stlNamespaceId,stlTypeId
    " }}}

    if !exists('cpp_no_cpp11') " {{{
        syntax keyword stlTypeId    contained atto
        syntax keyword stlTypeId    contained centi
        syntax keyword stlTypeId    contained const_local_iterator
        syntax keyword stlTypeId    contained deca
        syntax keyword stlTypeId    contained deci
        syntax keyword stlTypeId    contained double_t
        syntax keyword stlTypeId    contained exa
        syntax keyword stlTypeId    contained false_type
        syntax keyword stlTypeId    contained femto
        syntax keyword stlTypeId    contained float_t
        syntax keyword stlTypeId    contained giga
        syntax keyword stlTypeId    contained hasher
        syntax keyword stlTypeId    contained hecto
        syntax keyword stlTypeId    contained imaxdiv_t
        syntax keyword stlTypeId    contained int_fast8_t
        syntax keyword stlTypeId    contained int_fast16_t
        syntax keyword stlTypeId    contained int_fast32_t
        syntax keyword stlTypeId    contained int_fast64_t
        syntax keyword stlTypeId    contained int_least8_t
        syntax keyword stlTypeId    contained int_least16_t
        syntax keyword stlTypeId    contained int_least32_t
        syntax keyword stlTypeId    contained int_least64_t
        syntax keyword stlTypeId    contained int8_t
        syntax keyword stlTypeId    contained int16_t
        syntax keyword stlTypeId    contained int32_t
        syntax keyword stlTypeId    contained int64_t
        syntax keyword stlTypeId    contained intmax_t
        syntax keyword stlTypeId    contained intptr_t
        syntax keyword stlTypeId    contained key_equal
        syntax keyword stlTypeId    contained kilo
        syntax keyword stlTypeId    contained lldiv_t
        syntax keyword stlTypeId    contained local_iterator
        syntax keyword stlTypeId    contained max_align_t
        syntax keyword stlTypeId    contained mega
        syntax keyword stlTypeId    contained micro
        syntax keyword stlTypeId    contained milli
        syntax keyword stlTypeId    contained mutex_type
        syntax keyword stlTypeId    contained nano
        syntax keyword stlTypeId    contained native_handle_type
        syntax keyword stlTypeId    contained nullptr_t
        syntax keyword stlTypeId    contained param_type
        syntax keyword stlTypeId    contained peta
        syntax keyword stlTypeId    contained pico
        syntax keyword stlTypeId    contained tera
        syntax keyword stlTypeId    contained true_type
        syntax keyword stlTypeId    contained type
        syntax keyword stlTypeId    contained uint_fast8_t
        syntax keyword stlTypeId    contained uint_fast16_t
        syntax keyword stlTypeId    contained uint_fast32_t
        syntax keyword stlTypeId    contained uint_fast64_t
        syntax keyword stlTypeId    contained uint_least8_t
        syntax keyword stlTypeId    contained uint_least16_t
        syntax keyword stlTypeId    contained uint_least32_t
        syntax keyword stlTypeId    contained uint_least64_t
        syntax keyword stlTypeId    contained uint8_t
        syntax keyword stlTypeId    contained uint16_t
        syntax keyword stlTypeId    contained uint32_t
        syntax keyword stlTypeId    contained uint64_t
        syntax keyword stlTypeId    contained uintmax_t
        syntax keyword stlTypeId    contained uintptr_t
        syntax keyword stlTypeId    contained yocto
        syntax keyword stlTypeId    contained yotta
        syntax keyword stlTypeId    contained zepto
        syntax keyword stlTypeId    contained zetta
        syntax match   stlType      /::\(const_local_iterator\|hasher\|key_equal\|local_iterator\|type\)/ contains=stlTypeId
        syntax match   stlType      /std::\(\(condition_variable\|mutex\|thread\)::native_handle_type\|\(lock_guard\|unique_lock\)::mutex_type\)\>/ contains=stlNamespaceId,stlClassId,stlTypeId
        syntax match   stlType      /std::\(double\|float\|imaxdiv\|lldiv\)_t/ contains=stlNamespaceId,stlTypeId
        syntax match   stlType      /std::\(random_device\|\(discard_block\|independent_bits\|linear_congruential\|mersenne_twister\|shuffle_order\|subtract_with_carry\)_engine\)::result_type/ contains=stlNamespaceId,stlClassId,stlTypeId
        syntax match   stlType      /std::\(bernoulli\|\(negative_\)\?binomial\|cauchy\|chi_squared\|discrete\|exponential\|extreme_value\|fisher_f\|gamma\|geometric\|\(log\)\?normal\|piecewise_\(constant\|linear\)\|poisson\|student_t\|uniform_\(int\|real\)\|weibull\)_distribution::\(result_type\|param_type\)/ contains=stlNamespaceId,stlClassId,stlTypeId
        syntax match   stlType      /std::ratio\(_add\|_divide\|_equal\|_greater\(_equal\)\?\|_less\(_equal\)\?\|_multiply\|_not_equal\|_subtract\)\?::type/ contains=stlNamespaceId,stlClassId,stlTypeId
        syntax match   stlType      /\<std::\(atto\|centi\|deca\|deci\|exa\|femto\|giga\|hecto\|kilo\|mega\|micro\|milli\|nano\|peta\|pico\|tera\|yocto\|yotta\|zepto\|zetta\)\>/ contains=stlNamespaceId,stlTypeId
        syntax match   stlType      /\<std::u\?int\(\(_fast\|_least\)\?\(8\|16\|32\|64\)\|max\|ptr\)_t\>/ contains=stlNamespaceId,stlTypeId
        syntax match   stlType      /\<std::\(\(false\|true\)_type\|\(max_align\|nullptr\)_t\)\>/ contains=stlNamespaceId,stlTypeId
    endif
    " }}}

    if !exists('cpp_no_cpp14') " {{{
        syntax keyword stlTypeId    contained add_const_t
        syntax keyword stlTypeId    contained add_cv_t
        syntax keyword stlTypeId    contained add_lvalue_reference_t
        syntax keyword stlTypeId    contained add_pointer_t
        syntax keyword stlTypeId    contained add_rvalue_reference_t
        syntax keyword stlTypeId    contained add_volatile_t
        syntax keyword stlTypeId    contained aligned_storage_t
        syntax keyword stlTypeId    contained aligned_union_t
        syntax keyword stlTypeId    contained common_type_t
        syntax keyword stlTypeId    contained conditional_t
        syntax keyword stlTypeId    contained decay_t
        syntax keyword stlTypeId    contained enable_if_t
        syntax keyword stlTypeId    contained make_signed_t
        syntax keyword stlTypeId    contained make_unsigned_t
        syntax keyword stlTypeId    contained mutex_type
        syntax keyword stlTypeId    contained remove_all_extents_t
        syntax keyword stlTypeId    contained remove_const_t
        syntax keyword stlTypeId    contained remove_cv_t
        syntax keyword stlTypeId    contained remove_extent_t
        syntax keyword stlTypeId    contained remove_pointer_t
        syntax keyword stlTypeId    contained remove_reference_t
        syntax keyword stlTypeId    contained remove_volatile_t
        syntax keyword stlTypeId    contained result_of_t
        syntax keyword stlTypeId    contained underlying_type_t
        syntax match   stlType      /std::shared_lock::mutex_type\>/ contains=stlNamespaceId,stlClassId,stlTypeId
        syntax match   stlType      /\<std::\(add_\(const\|cv\|[lr]value_reference\|pointer\|volatile\)\|aligned_\(storage\|union\)\|common_type\|conditional\|decay\|enable_if\|make_\(signed\|unsigned\)\|remove_\(all_extents\|const\|cv\|extent\|pointer\|reference\|volatile\)\|result_of\|underlying_type\)_t\>/ contains=stlNamespaceId,stlTypeId
    endif
    " }}}
" }}}

" variables {{{
if !exists('cpp_no_cpp11')
    syntax keyword stlVariableId    contained default_random_engine
    syntax keyword stlVariableId    contained knuth_b
    syntax keyword stlVariableId    contained minstd_rand
    syntax keyword stlVariableId    contained minstd_rand0
    syntax keyword stlVariableId    contained mt19937
    syntax keyword stlVariableId    contained mt19937_64
    syntax keyword stlVariableId    contained ranlux24
    syntax keyword stlVariableId    contained ranlux24_base
    syntax keyword stlVariableId    contained ranlux48
    syntax keyword stlVariableId    contained ranlux48_base
    syntax match   stlVariable      /std::\(default_random_engine\|knuth_b\|minstd_rand\|minstd_rand0\|mt19937\|mt19937_64\|ranlux24\|ranlux24_base\|ranlux48\|ranlux48_base\)/ contains=stlNamespaceId,stlVariableId
endif
" }}}

" TODO  {{{
" ""s operator (from C++ 14)
" ""[if|i|il] operator (from C++14)
" helper classes
" std::glsice               class
" std::glsice_array         class template
" std::indirect_array       class template
" std::is_error_code_enum   class template
" std::mask_array           class template
" std::slice                class
" std::slice_array          class template
" std::uses_allocator       class template
"
" why does (method_name highlight the word as a function? it should be
" restricted to .method_name and ->method_name.
" }}}

" highlighting {{{
highlight         link cConstant        stlMacroConstId
highlight default link stlClassId       Structure
highlight default link stlConstantId    Constant
highlight default link stlEnumerationId Structure
highlight default link stlEnumeratorId  Constant
highlight default link stlError         Error
highlight default link stlFunctionId    Function
highlight default link stlMacroConstId  Macro
highlight default link stlMacroFuncId   Macro
highlight default link stlMemberId      stlVariableId
highlight default link stlMethodId      Function
highlight default link stlNamespaceId   Structure
highlight default link stlTypeId        Typedef
highlight default link stlVariableId    Identifier
"}}}

