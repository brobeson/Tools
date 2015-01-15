" Vim syntax file
" Language:		C++ STL
" Maintainer:	brobeson (http://github.com/brobeson/Tools)
" Last Change:	17 December 2014

" use this variable to control whether object methods should be
" highlighted.
let stl_highlight_methods = 1
let cpp_no_cpp11 = 1
let cpp_no_cpp14 = 1
let cpp_no_cpp17 = 1

syntax keyword stlNamespace std

" TODO utilities {{{
"		" type support {{{
"		" TODO	verify this
"		syntax match   stlTypedef "std::\(max_align\|nullptr\|ptrdiff\|size\)_t"
"		syntax keyword stlMacro   __alignas_is_defined __bool_true_false_are_defined offsetof
"
"		" fixed width integer types
"		" most of these are already in the cpp.vim
"		syntax keyword stlMacro INT8_C INT16_C INT32_C INT64_C INTMAX_C UINT8_C UINT16_C UINT32_C UINT64_C UINTMAX_C
"
"		" numeric limits
"		" most of the C macros are already in cpp.vim
"		syntax match   stlTemplate "std::numeric_limits"
"		syntax match   stlConstant "std::numeric_limits::has_\(infinity\|quiet_NaN\|signaling_NaN\|denorm\|denorm_loss\)"
"		syntax match   stlConstant "std::numeric_limits::is_\(specialized\|signed\|integer\|exact\|iec559\|bounded\|modulo\)"
"		syntax match   stlConstant "std::numeric_limits::\(digits\(10\)\?\|max_digits10\|max_exponent\(10\)\?\|min_exponent\(10\)\?\)"
"		syntax match   stlConstant "std::numeric_limits::\(radix\|round_style\|tinyness_before\|traps\)"
"		syntax match   stlFunction "std::numeric_limits::\(denorm_min\|epsilon\|infinity\|lowest\|max\|min\|quet_NaN\|round_error\|signaling_NaN\)"
"		syntax keyword stlMacro    DECIMAL_DIG FLT_EVAL_METHOD
"
"		" runtime type identification
"		" std::bad_typeid and bad_cast are documented with the other exceptions
"		syntax match stlClass "std::type_\(index\|info\)"
"		if exists("stl_highlight_methods")
"			syntax match stlMethod "\.\(before\|hash_code\|name\)"ms=s+1
"		endif
"
"		" type traits
"		syntax match stlTemplate "std::is_\(abstract\|arithmetic\|array\|base_of\|class\|compound\|const\|convertible\)"
"		syntax match stlTemplate "std::is_\(empty\|enum\|final\|floating_point\|function\|fundamental\|integral\)"
"		syntax match stlTemplate "std::is_\(literal_type\|lvalue_reference\|member_function_pointer\|member_object_pointer\)"
"		syntax match stlTemplate "std::is_\(member_pointer\|null_pointer\|object\|pod\|pointer\|polymorphic\|reference\)"
"		syntax match stlTemplate "std::is_\(rvalue_reference\|same\|scalar\|signed\|standard_layout\|trivial\)"
"		syntax match stlTemplate "std::is_\(trivially_copyable\|union\|unsigned\|void\|volatile\)"
"		syntax match stlTemplate "std::is_\(nothrow_\|trivially_\)\?\(copy_\|default_\|move_\)\?\(constructible\|assignable\)"
"		syntax match stlTemplate "std::is_\(nothrow_\|trivially_\)\?destructible"
"		syntax match stlTemplate "std::\(alignment_of\|extent\|has_virtual_destructor\|rank\)"
"		syntax match stlMember   "std::is_\(abstract\|arithmetic\|array\|base_of\|class\|compound\|const\|convertible\)::value"
"		syntax match stlMember   "std::is_\(empty\|enum\|final\|floating_point\|function\|fundamental\|integral\)::value"
"		syntax match stlMember   "std::is_\(literal_type\|lvalue_reference\|member_function_pointer\|member_object_pointer\)::value"
"		syntax match stlMember   "std::is_\(member_pointer\|null_pointer\|object\|pod\|pointer\|polymorphic\|reference\)::value"
"		syntax match stlMember   "std::is_\(rvalue_reference\|same\|scalar\|signed\|standard_layout\|trivial\)::value"
"		syntax match stlMember   "std::is_\(trivially_copyable\|union\|unsigned\|void\|volatile\)::value"
"		syntax match stlMember   "std::is_\(nothrow_\|trivially_\)\?\(copy_\|default_\|move_\)\?\(constructible\|assignable\)::value"
"		syntax match stlMember   "std::is_\(nothrow_\|trivially_\)\?destructible::value"
"		syntax match stlMember   "std::\(alignment_of\|extent\|has_virtual_destructor\|rank\)::value"
"
"		" type modifications
"		syntax match stlTemplate "std::\(add\|remove\)_\(const\|cv\|pointer\|volatile\)"
"		syntax match stlTemplate "std::\(add_[rl]value\|remove\)_reference"
"		syntax match stlTemplate "std::remove_\(all_\)\?extent"
"		syntax match stlTemplate "make_\(un\)\?signed"
"		syntax match stlMember   "std::\(add\|remove\)_\(const\|cv\|pointer\|volatile\)::value"
"		syntax match stlMember   "std::\(add_[rl]value\|remove\)_reference::value"
"		syntax match stlMember   "std::remove_\(all_\)\?extent::value"
"		syntax match stlMember   "make_\(un\)\?signed::value"
"
"		" miscellaneous transformations
"		syntax match stlTemplate "std::\(aligned_storage\|aligned_union\|common_type\|conditional\|decay\|enable_if\|result_of\|underlying_type\)"
"		syntax match stlMember   "std::\(aligned_storage\|aligned_union\|common_type\|conditional\|decay\|enable_if\|result_of\|underlying_type\)::type"
"		syntax match stlConstant "std::aligned_union::alignment_value"
"
"		" helper classes
"		syntax match stlTemplate "std::integral_constant"
"		syntax match stlConstant "std::integral_constant::value"
"		" }}}
"
"		" dynamic memory management {{{
"		" TODO	verify this
"		" smart pointers
"		syntax match stlTemplate "std::\(unique\|shared\|weak\|auto\)_ptr"
"		syntax match stlTemplate "std::\(owner_less\|enable_shared_from_this\|default_delete\)"
"		syntax match stlFunction "std::\(allocate_shared\|const_pointer_cast\|dynamic_pointer_cast\|get_deleter\)"
"		syntax match stlFunction "std::\(make_shared\|make_unique\|static_pointer_cast\)"
"		if exists("stl_highlight_methods")
"			syntax match stlMethod "\.\(expired\|get_deleter\|lock\|owner_before\|release\|reset\|shared_from_this\|unique\|use_count\)"
"		endif
"
"		" allocators
"		syntax match stlTemplate "std::\(allocator\|allocator_traits\|uses_allocator\|scoped_allocator_adaptor\)"
"		syntax match stlClass    "std::allocator_arg_t"
"		syntax match stlConstant "std::allocator_arg"
"		syntax match stlFunction "std::allocator_traits::\(allocate\|construct\|deallocate\|destroy\|max_size\|select_on_container_copy_construction\)"
"		syntax match stlConstant "std::uses_allocator::value"
"		if exists("stl_highlight_methods")
"			syntax match stlMethod "\.\(address\|allocate\|construct\|deallocate\|destroy\|inner_allocator\|max_size\|outer_allocator\|select-on_contain_copy_construction\)"
"		endif
"		
"		" uninitialized storage
"		syntax match stlTemplate "std::raw_storage_iterator"
"		syntax match stlFunction "std::\(uninitialized_\(copy\|copy_n\|fill\|fill_n\)\)"
"		syntax match stlFunction "std::\(get_temporary_buffer\|return_temporary_buffer\)"
"
"		" garbage collector support
"		syntax match stlEnumeration "std::pointer_safety"
"		syntax match stlEnumValue   "std::pointer_safety::\(preferred\|relaxed\|strict\)"
"		syntax match stlFunction    "std::\(un\)\?declare_\(reachable\|no_pointers\)"
"		syntax match stlFunction    "std::get_pointer_safety"
"
"		" miscellaneous
"		syntax match stlTemplate "std::pointer_traits"
"		syntax match stlFunction "std::pointer_traits::pointer_to"
"		syntax match stlFunction "std::\(addressof\|align\)"
"
"		" C-style memory management
"		syntax match stlFunction "std::\(calloc\|free\|malloc\|realloc\)"
"
"		" low level memory management
"		syntax match stlFunction "std::[gs]et_new_handler"
"		syntax match stlConstant "std::nothrow"
"		syntax match stlClass    "std::nothrow_t"
"		syntax match stlTypedef  "std::new_handler"
"		" }}}
"	" }}}

" WORKING ON string objects and character arrays {{{
" STL string objects
" TODO	""s operator
syntax keyword stl11TypeId			u16string u32string
syntax keyword stl11FunctionId		stod stof stoi stol stold stoll stoul stoull to_string to_wstring
syntax keyword stlConstantId		npos
syntax keyword stlMethodId			append c_str compare data eof eq eq_int_type find_first_not_of find_last_not_of find_last_of length lt move not_eof rfind substr to_char_type to_int_type
syntax keyword stlClassId			basic_string char_traits
syntax keyword stlTypeId			char_type int_type off_type pos_type state_type string traits_type wstring

"	" TODO verify this
"	syntax match stlFunction "std::\(getline\|swap
"	if exists("stl_highlight_methods")
"		syntax match stlMethod "\.\(\|assign\|at\|back\|begin\|\|capacity\|cbegin\|cend\)"ms=s+1
"		syntax match stlMethod "\.\(clear\|\|copy\|crbegin\|crend\|empty\|end\|\|erase\)"ms=s+1
"		syntax match stlMethod "\.\(find\|\|find_first_of\|\)"ms=s+1
"		syntax match stlMethod "\.\(\|front\|get_allocator\|insert\|\|max_size\)"ms=s+1
"		syntax match stlMethod "\.\(pop_back\|push_back\|rbegin\|rend\|replace\|reserve\|resize\)"ms=s+1
"		syntax match stlMethod "\.\(\|shrink_to_fit\|size\|\|swap\)"ms=s+1
"	endif
"
"	" null terminated byte strings
"	syntax match stlFunction "std::is\(alnum\|alpha\|lower\|upper\|digit\|xdigit\|cntrl\|graph\|space\|blank\|print\|punct\)"
"	syntax match stlFunction "std::to\(lower\|upper\)"
"	syntax match stlFunction "std::ato\(f\|i\|l\|ll\)"
"	syntax match stlFunction "std::strto\(l\|ll\|ul\|ull\|f\|d\|ld\|imax\|umax\)"
"	syntax match stlFunction "std::str\(cpy\|ncpy\|cat\|ncat\|xfrm\|len\|cmp\|ncmp\|coll\|chr\|rchr\|spn\|cspn\|pbrk\|str\|tok\|error\)"
"	syntax match stlFunction "std::mem\(chr\|cmp\|set\|cpy\|move\)"
"
"	" null terminated multibyte strings
"	syntax match   stlFunction "std::mb\(len\|towc\|stowcs\|sinit\|rlen\|rtowc\|srtowcs\|rtoc16\|rtoc32\)"
"	syntax match   stlFunction "std::wc\(tomb\|stombs\|tob\|rtomb\|srtombs\)"
"	syntax match   stlFunction "std::\(btowc\|c16rtomb\|c32rtomb\)"
"	syntax match   stlStruct   "std::mbstate_t"
"	syntax keyword stlMacro    MB_CUR_MAX __STDC_UTF_16__ __STDC_UTF_32__
"
"	" null terminated wide strings
"	syntax match   stlFunction "std::isw\(alnum\|alpha\|lower\|upper\|digit\|xdigit\|cntrl\|graph\|space\|blank\|print\|punct\|ctype\)"
"	syntax match   stlFunction "std::wc\(type\|trans\)"
"	syntax match   stlFunction "std::tow\(lower\|upper\|ctrans\)"
"	syntax match   stlFunction "std::wcsto\(l\|ll\|ul\|ull\|f\|d\|ld\|imax\|umax\)"
"	syntax match   stlFunction "std::wcs\(cpy\|ncpy\|cat\|ncat\|xfrm\|len\|cmp\|ncmp\|coll\|chr\|rchr\|spn\|cspn\|pbrk\|str\|tok\)"
"	syntax match   stlFunction "std::wmem\(chr\|cmp\|set\|cpy\|move\)"
"	syntax match   stlStruct   "std::\(wctrans_t\|wctype_t\|wint_t\)"
"	syntax keyword stlMacro    WEOF
"	" }}}

" containers {{{
syntax keyword stlContainerId	deque list map multimap multiset priority_queue queue set stack vector
syntax keyword stlMemberClassId value_compare
syntax keyword stlMemberId		c comp
syntax keyword stlMethodId		assign at back begin capacity cbegin cend clear count crbegin crend empty end equal_range erase find front
syntax keyword stlMethodId		get_allocator insert key_comp lower_bound max_size merge pop pop_back pop_front push push_back push_front
syntax keyword stlMethodId		rbegin remove remove_if rend reserve resize reverse size sort splice swap top unique upper_bound value_comp
syntax keyword stlTypeId		allocator_type const_iterator const_pointer const_reference const_reverse_iterator container_type
syntax keyword stlTypeId		difference_type first_argument_type iterator key_compare key_type mapped_type pointer reference result_type
syntax keyword stlTypeId		reverse_iterator second_argument_type size_type value_type

" added in C++11
syntax keyword stl11ContainerId	array forward_list unordered_map unordered_multimap unordered_multiset unordered_set
syntax keyword stl11FunctionId	get
syntax keyword stl11MethodId	before_begin bucket bucket_count bucket_size cbefore_begin emplace emplace_after emplace_back
syntax keyword stl11MethodId	emplace_front emplace_hint erase_after fill hash_function insert_after key_eq load_factor max_bucket_count
syntax keyword stl11MethodId	max_load_factor rehash shrink_to_fit splice_after
syntax keyword stl11TypeId		const_local_iterator hasher key_equal local_iterator

" added in C++17
syntax keyword stl17MethodId	insert_or_assign try_emplace

" helper classes
"	tuple_element
"	tuple_size
"	uses_allocator

"syntax match stlContainer	/stl::\(deque\|list\|map\|multimap\|multiset\|priority_queue\|queue\|set\|stack\|vector\)/ contains=stdContainerId
"syntax match stlClass     "stl::\(multi\)\?map::value_compare"
"syntax match stlFunction  "std::get"
"if exists("stl_highlight_methods")
"	syntax match stlMethod "\.\(before_begin\|bucket\|bucket_count\|bucket_size\|cbefore_begin\|count\|emplace\)"ms=s+1
"	syntax match stlMethod "\.\(emplace_after\|emplace_back\|emplace_front\|emplace_hint\|equal_range\|erase_after\)"ms=s+1
"	syntax match stlMethod "\.\(fill\|hash_function\|insert_after\|insert_or_assign\|key_comp\|key_eq\|load_factor\)"ms=s+1
"	syntax match stlMethod "\.\(lower_bound\|max_bucket_count\|max_load_factor\|merge\|pop\|pop_front\|push\)"ms=s+1
"	syntax match stlMethod "\.\(push_front\|rehash\|remove\|remove_if\|reverse\|sort\|splice\|splice_after\|top\)"ms=s+1
"	syntax match stlMethod "\.\(try_emplace\|unique\|upper_bound\|value_comp\)"ms=s+1
"endif
" }}}

" algorithms {{{
	syntax keyword stlFunctionId	accumulate adjacent_difference adjacent_find binary_search bsearch copy copy_backward count count_if
	syntax keyword stlFunctionId	equal equal_range fill fill_n find find_end find_first_of find_if for_each generate generate_n includes
	syntax keyword stlFunctionId	inner_product inplace_merge iter_swap lexicographical_compare lower_bound max max_element make_heap
	syntax keyword stlFunctionId	merge min min_element mismatch next_permutation nth_element partial_sort partial_sort_copy partial_sum
	syntax keyword stlFunctionId	partition pop_heap prev_permutation push_heap qsort remove remove_copy remove_copy_if remove_if replace
	syntax keyword stlFunctionId	replace_copy replace_copy_if replace_if reverse reverse_copy rotate rotate_copy search search_n
	syntax keyword stlFunctionId	set_difference set_intersection set_symmetric_difference set_union sort sort_heap stable_partition
	syntax keyword stlFunctionId	stable_sort swap swap_ranges transform unique unique_copy upper_bound

	syntax keyword stl11FunctionId	all_of any_of copy_if copy_n find_if_not iota is_heap is_heap_until is_partitioned is_permutation
	syntax keyword stl11FunctionId	is_sorted is_sorted_until minmax minmax_element move_backward none_of partition_copy
	syntax keyword stl11FunctionId	partition_point shuffle

	syntax keyword stl14DepFunctionId random_shuffle
" }}}

" TODO iterators {{{
" }}}

" TODO numerics {{{
" }}}

" TODO input/output {{{
" }}}

" TODO localizations {{{
" }}}

" TODO regular expressions {{{
" }}}

" TODO atomic operations {{{
" }}}

" TODO thread support {{{
" }}}

" highlighting {{{
 highlight default link stlClassId       Structure
 highlight default link stlConstantId    Constant
 highlight default link stlContainerId   Structure
"highlight default link stlEnumeration   Type
"highlight default link stlEnumValue     Constant
"highlight default link stlError         Error
 highlight default link stlFunctionId    Function
"highlight default link stlMacro         Macro
 highlight default link stlMemberId      Identifier
 highlight default link stlMemberClassId Structure
 highlight default link stlNamespace     Structure
"highlight default link stlStruct        Structure
"highlight default link stlTemplate      Structure
 highlight default link stlTypeId        Typedef

" highlighting of methods
if exists("stl_highlight_methods")
	highlight default link stlMethodId Function
	if exists("cpp_no_cpp11")
		highlight default link stl11MethodId Error
	else
		highlight default link stl11MethodId stlMethodId
	endif
	if exists("cpp_no_cpp17")
		highlight default link stl17MethodId Error
	else
		highlight default link stl17MethodId stlMethodId
	endif
endif

" highlighting of C++11 STL changes
if exists("cpp_no_cpp11")
	highlight default link stl11ContainerId Error
	highlight default link stl11FunctionId  Error
"	"highlight default link stl11Template Error
	highlight default link stl11TypeId      Error
else
	highlight default link stl11ContainerId stlContainerId
	highlight default link stl11FunctionId  stlFunctionId
"	"highlight default link stl11Template stlTemplate
	highlight default link stl11TypeId      stlTypeId
endif

" deprecated & removed functionality
if exists("cpp_no_cpp14") && exists("cpp_no_cpp17")
	highlight default link stl14DepFunctionId Function
else
	highlight default link stl14DepFunctionId Error
endif
"}}}

"================================================================
" I initially copied this from https://github.com/Mizuchi/STL-Syntax. I'm only using it to point out some STL functionality I may miss in my own file.
"================================================================
