" Vim syntax file
" Language:		C++ STL
" Maintainer:	brobeson (http://github.com/brobeson/Tools)
" Last Change:	17 December 2014

" use this variable to control whether object methods should be
" highlighted.
let stl_highlight_methods = 1
"let cpp_no_cpp11 = 1
"let cpp_no_cpp14 = 1
"let cpp_no_cpp17 = 1

syntax keyword stlNamespaceId contained std

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
syntax keyword stl11TypeId		contained u16string u32string
syntax keyword stl11FunctionId	contained stod stof stoi stol stold stoll stoul stoull to_string to_wstring
syntax keyword stlConstantId	contained npos
syntax keyword stlClassId		contained basic_string char_traits
syntax keyword stlMethodId		contained append c_str compare data eof eq eq_int_type find_first_not_of find_last_not_of find_last_of length lt move not_eof rfind substr to_char_type to_int_type
syntax keyword stlTypeId		contained char_type int_type off_type pos_type state_type string traits_type wstring

syntax match stlConstant	/::npos/ contains=stlConstantId
syntax match stlClass		/std::\(basic_string\|char_traits\)/ contains=stlNamespaceId,stlClassId
syntax match stlFunction	/::\(assign\|eq\|lt\|move\|copy\|compare\|length\|find\|to_char_type\|to_int_type\|eq_int_type\|eof\|not_eof\)/ contains=stlMethodId,stlFunctionId
syntax match stlMethod		/\.\(append\|c_str\|compare\|copy\|data\|eof\|eq\|eq_int_type\|find_first_not_of\|find_last_not_of\|find_last_of\|length\|lt\|move\|not_eof\|rfind\|substr\|to_char_type\|to_int_type\)/ contains=stlMethodId,stlFunctionId
"syntax match blah			'\.c_str' contains=stlMethodId
"syntax match blah			/\.cstr/
syntax match stlType		/std::\(string\|u16string\|u32string\|wstring\)/ contains=stlNamespaceId,stlTypeId,stl11TypeId
syntax match stlType		/::\(char_type\|int_type\|off_type\|pos_type\|state_type\|traits_type\)/ contains=stlTypeId
syntax match stl11Function	/std::\(sto\(d\|f\|i\|l\|ld\|ll\|ul\|ull\)\|to_w\?string\)/ contains=stl11FunctionId,stlNamespaceId
"	" }}}

" containers {{{
syntax keyword stlClassId	contained deque list map multimap multiset priority_queue queue set stack value_compare vector
syntax keyword stlMemberId	contained c comp
syntax keyword stlMethodId	contained assign at back begin capacity cbegin cend clear count crbegin crend empty end equal_range erase find front
syntax keyword stlMethodId	contained get_allocator insert key_comp lower_bound max_size merge pop pop_back pop_front push push_back push_front
syntax keyword stlMethodId	contained rbegin remove remove_if rend reserve resize reverse size sort splice swap top unique upper_bound value_comp
syntax keyword stlTypeId	contained allocator_type const_iterator const_pointer const_reference const_reverse_iterator container_type
syntax keyword stlTypeId	contained difference_type first_argument_type iterator key_compare key_type mapped_type pointer reference result_type
syntax keyword stlTypeId	contained reverse_iterator second_argument_type size_type value_type

" added in C++11
syntax keyword stl11ClassId		contained array forward_list unordered_map unordered_multimap unordered_multiset unordered_set
syntax keyword stl11FunctionId	contained get
syntax keyword stl11MethodId	contained before_begin bucket bucket_count bucket_size cbefore_begin data emplace emplace_after emplace_back
syntax keyword stl11MethodId	contained emplace_front emplace_hint erase_after fill hash_function insert_after key_eq load_factor max_bucket_count
syntax keyword stl11MethodId	contained max_load_factor rehash shrink_to_fit splice_after
syntax keyword stl11TypeId		contained const_local_iterator hasher key_equal local_iterator

" added in C++17
syntax keyword stl17MethodId	contained insert_or_assign try_emplace

syntax match stlClass		/std::\(deque\|list\|map\|multimap\|multiset\|priority_queue\|queue\|set\|stack\|vector\|contained\|array\|forward_list\|unordered_map\|unordered_multimap\|unordered_multiset\|unordered_set\)/ contains=stlNamespaceId,stl11ClassId,stlClassId
syntax match stlClass		/::value_compare/ contains=stlClassId
syntax match stlFunction	/std::get/ contains=stlNamespaceId,stl11FunctionId
syntax match stlMember		/\.c\(comp\)\?/ contains=stlMemberId
syntax match stlMethod		/\.\(assign\|at\|back\|begin\|capacity\|cbegin\|cend\|clear\|count\|crbegin\|crend\|data\|empty\|end\|equal_range\|erase\|find\|front\|get_allocator\|insert\|insert_or_assign\|key_comp\|lower_bound\|max_size\|merge\|pop\|pop_back\|pop_front\|push\|push_back\|push_front\|rbegin\|remove\|remove_if\|rend\|reserve\|resize\|reverse\|size\|sort\|splice\|swap\|top\|unique\|upper_bound\|value_comp\|before_begin\|bucket\|bucket_count\|bucket_size\|cbefore_begin\|emplace\|emplace_after\|emplace_back\|emplace_front\|emplace_hint\|erase_after\|fill\|hash_function\|insert_after\|key_eq\|load_factor\|max_bucket_count\|max_load_factor\|rehash\|shrink_to_fit\|splice_after\|try_emplace\)/ contains=stlMethodId,stl11MethodId,stl17MethodId
syntax match stlType		/::\(allocator_type\|const_iterator\|const_local_iterator\|const_pointer\|const_reference\|const_reverse_iterator\|container_type\|difference_type\|first_argument_type\|hasher\|iterator\|key_compare\|key_equal\|key_type\|local_iterator\|mapped_type\|pointer\|reference\|result_type\|reverse_iterator\|second_argument_type\|size_type\|value_type\)/ contains=stlTypeId,stl11TypeId

" helper classes
"	tuple_element
"	tuple_size
"	uses_allocator
" }}}

" algorithms {{{
syntax keyword stlFunctionId		contained accumulate adjacent_difference adjacent_find binary_search bsearch copy copy_backward count count_if
syntax keyword stlFunctionId		contained equal equal_range fill fill_n find find_end find_first_of find_if for_each generate generate_n includes
syntax keyword stlFunctionId		contained inner_product inplace_merge iter_swap lexicographical_compare lower_bound max max_element make_heap
syntax keyword stlFunctionId		contained merge min min_element mismatch next_permutation nth_element partial_sort partial_sort_copy partial_sum
syntax keyword stlFunctionId		contained partition pop_heap prev_permutation push_heap qsort remove remove_copy remove_copy_if remove_if replace
syntax keyword stlFunctionId		contained replace_copy replace_copy_if replace_if reverse reverse_copy rotate rotate_copy search search_n
syntax keyword stlFunctionId		contained set_difference set_intersection set_symmetric_difference set_union sort sort_heap stable_partition
syntax keyword stlFunctionId		contained stable_sort swap swap_ranges transform unique unique_copy upper_bound
syntax keyword stl11FunctionId		contained all_of any_of copy_if copy_n find_if_not iota is_heap is_heap_until is_partitioned is_permutation
syntax keyword stl11FunctionId		contained is_sorted is_sorted_until minmax minmax_element move_backward none_of partition_copy
syntax keyword stl11FunctionId		contained partition_point shuffle
syntax keyword stl14DepFunctionId	contained random_shuffle

syntax match stlFunction	/std::\(accumulate\|adjacent_difference\|adjacent_find\|all_of\|any_of\|binary_search\|bsearch\|copy\|copy_backward\|copy_if\|copy_n\|count\|count_if\|equal\|equal_range\|fill\|fill_n\|find\|find_end\|find_first_of\|find_if\|find_if_not\|for_each\|generate\|generate_n\|includes\|inner_product\|inplace_merge\|iota\|is_heap\(_until\)\?\|is_partitioned\|is_permutation\|is_sorted\(_until\)\?\|iter_swap\|lexicographical_compare\|lower_bound\|max\|max_element\|make_heap\|merge\|min\|min_element\|minmax\(_element\)\?\|mismatch\|next_permutation\|none_of\|nth_element\|partial_sort\|partial_sort_copy\|partial_sum\|partition\|partition_copy\|partition_point\|pop_heap\|prev_permutation\|push_heap\|qsort\|random_shuffle\|remove\|remove_copy\|remove_copy_if\|remove_if\|replace\|replace_copy\|replace_copy_if\|replace_if\|reverse\|reverse_copy\|rotate\|rotate_copy\|search\|search_n\|set_difference\|set_intersection\|set_symmetric_difference\|set_union\|shuffle\|sort\|sort_heap\|stable_partition\|stable_sort\|swap\|swap_ranges\|transform\|unique\|unique_copy\|upper_bound\)/ contains=stlNamespaceId,stlFunctionId,stl11FunctionId,stl14DepFunctionId

" 'move' is a valid string method. so to highlight it correctly as a std
" function, we need this match. the '_backward' part is to correctly match the
" std function 'move_backward'
syntax match stl11Function	/std::move\(_backward\)\?/hs=s+5 contains=stlNamespaceId
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

" thread support {{{
syntax keyword stl11ClassId		contained adopt_lock_t condition_variable condition_variable_any defer_lock_t
syntax keyword stl11ClassId		contained future future_error id lock_guard mutex once_flag packaged_task promise
syntax keyword stl11ClassId		contained recursive_mutex recursive_timed_mutex shared_future thread timed_mutex
syntax keyword stl11ClassId		contained try_to_lock_t unique_lock
syntax keyword stl11MethodId	contained code detach get get_future get_id join joinable lock make_ready_at_thread_exit
syntax keyword stl11MethodId	contained mutex native_handle notify_all notify_one owns_lock release reset
syntax keyword stl11MethodId	contained set_exception set_exception_at_thread_exit set_value set_value_at_thread_exit
syntax keyword stl11MethodId	contained share swap try_lock try_lock_for try_lock_until unlock valid wait wait_for
syntax keyword stl11MethodId	contained wait_until what
syntax keyword stl11TypeId		contained mutex_type native_handle_type
syntax keyword stl11ConstantId	contained async adopt_lock broken_promise defer_lock deferred future_already_retrieved
syntax keyword stl11ConstantId	contained no_state no_timeout promise_already_satisfied ready timeout try_to_lock
syntax keyword stl11EnumId		contained cv_status future_errc future_status launch
syntax keyword stl11FunctionId	contained async call_once future_category get_id hardware_concurrency hash lock
syntax keyword stl11FunctionId	contained make_error_code make_error_condition notify_all_at_thread_exit sleep_for
syntax keyword stl11FunctionId	contained sleep_until swap try_lock yield
syntax keyword stl14ClassId		contained shared_lock shared_timed_mutex
syntax keyword stl14MethodId	contained lock_shared try_lock_shared try_lock_shared_for try_lock_shared_until unlock_shared

syntax match stlClass		/std::\(adopt_lock_t\|condition_variable\|condition_variable_any\|defer_lock_t\|future\|future_error\|lock_guard\|mutex\|once_flag\|packaged_task\|promise\|recursive_mutex\|recursive_timed_mutex\|shared_future\|shared_lock\|shared_timed_mutex\|thread\(::id\)\?\|timed_mutex\|try_to_lock_t\|unique_lock\)\>/ contains=stlNamespaceId,stl11ClassId,stl14ClassId
syntax match stlConstant	/std::\(adopt_lock\|defer_lock\|try_to_lock\)\>/ contains=stlNamespaceId,stl11ConstantId
syntax match stlEnum		/std::cv_status\(::no_timeout\|::timeout\)\?/ contains=stlNamespaceId,stl11EnumId,stl11ConstantId
syntax match stlEnum		/std::future_errc\(::broken_promise\|::future_already_retrieved\|::promise_already_satisfied\|::no_state\)\?/ contains=stlNamespaceId,stl11EnumId,stl11ConstantId
syntax match stlEnum		/std::future_status\(::deferred\|::ready\|::timeout\)\?/ contains=stlNamespaceId,stl11EnumId,stl11ConstantId
syntax match stlEnum		/std::launch\(::async\|::deferred\)\?/ contains=stlNamespaceId,stl11EnumId,stl11ConstantId
syntax match stlFunction	/std::\(thread::hardware_concurrency\|async\|call_once\|get_id\|future_category\|hash\|lock\|make_error_code\|make_error_condition\|notify_all_at_thread_exit\|sleep_for\|sleep_until\|swap\|try_lock\|yield\)\>/ contains=stlNamespaceId,stl11ClassId,stl11FunctionId
syntax match stlMethod		/\.\(code\|detach\|get\|get_future\|get_id\|join\|joinable\|lock\|make_ready_at_thread_exit\|mutex\|native_handle\|notify_all\|notify_one\|owns_lock\|release\|reset\|set_exception\|set_exception_at_thread_exit\|set_value\|set_value_at_thread_exit\|share\|swap\|try_lock\|try_lock_for\|try_lock_until\|unlock\|valid\|wait\|wait_for\|wait_until\|what\)\>/ contains=stl11MethodId
syntax match stlMethod		/\.\(lock_shared\|try_lock_shared\|try_lock_shared_for\|try_lock_shared_until\|unlock_shared\)\>/ contains=stl14MethodId
syntax match stlType		/std::\(\(condition_variable\|mutex\|thread\)::native_handle_type\|\(lock_guard\|shared_lock\|unique_lock\)::mutex_type\)\>/ contains=stlNamespaceId,stl11ClassId,stl14ClassId,stl11TypeId

" C11
" std::call_once() is already covered as part of the C++ STL code
" std::once_flag is sort of covered as part the C++ STL code
syntax keyword stl11CConstantId		contained ONCE_FLAG_INIT thread_local TSS_DTOR_ITERATIONS
syntax keyword stl11CEnumeratorId	contained thrd_success thrd_timedout thrd_busy thrd_nomem thrd_error mtx_plain
syntax keyword stl11CEnumeratorId	contained mtx_recursive mtx_timed
syntax keyword stl11CFunctionId		contained cnd_broadcast cnd_destroy cnd_init cnd_signal cnd_timedwait cnd_wait mtx_destroy
syntax keyword stl11CFunctionId		contained mtx_init mtx_lock mtx_timedlock mtx_trylock mtx_unlock thrd_create thrd_current
syntax keyword stl11CFunctionId		contained thrd_detach thrd_equal thrd_exit thrd_join thrd_sleep thrd_yield tss_create
syntax keyword stl11CFunctionId		contained tss_delete tss_get tss_set
syntax keyword stl11CTypeId			contained cnd_t mtx_t thrd_t thrd_start_t tss_dtor_t tss_t

syntax match stlCConstant		/std::\(ONCE_FLAG_INIT\|thread_local\|TSS_DTOR_ITERATIONS\)/ contains=stlNamespaceId,stl11CConstantId
syntax match stlCEnumeration	/std::\(thrd_\(success\|timedout\|busy\|nomem\|error\)\|mtx_\(plain\|recursive\|timed\)\)/ contains=stlNamespaceId,stl11CEnumeratorId
syntax match stlCFunction		/std::\(cnd_\(broadcast\|destroy\|init\|signal\|timedwait\|wait\)\|mtx_\(destroy\|init\|lock\|timedlock\|trylock\|unlock\)\|thrd_\(create\|current\|detach\|equal\|exit\|join\|sleep\|yield\)\|tss_\(create\|delete\|get\|set\)\)/ contains=stlNamespaceId,stl11CFunctionId
syntax match stl11CType			/std::\(cnd_t\|mtx_t\|thrd_t\|thrd_start_t\|tss_dtor_t\|tss_t\)\>/ contains=stlNamespaceId,stl11CTypeId

" TODO	std::uses_allocator	class template
"		std::is_error_code_enum class template
" }}}

" highlighting {{{
 highlight default link stlClassId			Structure
 highlight default link stlConstantId		Constant
 highlight default link stlEnumId			Structure
 highlight default link stlError			Error
 highlight default link stlFunctionId		Function
"highlight default link stlMacro			Macro
 highlight default link stlMemberId			Identifier
 highlight default link stlNamespaceId		Structure
"highlight default link stlStruct			Structure
"highlight default link stlTemplate			Structure
 highlight default link stlTypeId			Typedef

" highlighting of methods
if exists("stl_highlight_methods")
	highlight default link stlMethodId stlFunctionId
	if exists("cpp_no_cpp11")
		highlight default link stl11MethodId stlError
	else
		highlight default link stl11MethodId stlMethodId
	endif
	if exists("cpp_no_cpp14")
		highlight default link stl14MethodId stlError
	else
		highlight default link stl14MethodId stlMethodId
	endif
	if exists("cpp_no_cpp17")
		highlight default link stl17MethodId stlError
	else
		highlight default link stl17MethodId stlMethodId
	endif
endif

" highlighting of C++11 STL changes
if exists("cpp_no_cpp11")
	highlight default link stl11CConstantId		stlError
	highlight default link stl11CEnumeratorId	stlError
	highlight default link stl11CFunctionId		stlError
	highlight default link stl11ClassId			stlError
	highlight default link stl11ConstantId		stlError
	highlight default link stl11CTypeId			stlError
	highlight default link stl11EnumId			stlError
	highlight default link stl11Function		stlError
	highlight default link stl11FunctionId		stlError
	"highlight default link stl11Template		stlError
	highlight default link stl11TypeId			stlError
else
	highlight default link stl11CConstantId		stlConstantId
	highlight default link stl11CEnumeratorId	stlConstantId
	highlight default link stl11CFunctionId		stlFunctionId
	highlight default link stl11ClassId			stlClassId
	highlight default link stl11ConstantId		stlConstantId
	highlight default link stl11CTypeId			stlTypeId
	highlight default link stl11EnumId			stlEnumId
	highlight default link stl11Function		stlFunctionId
	highlight default link stl11FunctionId		stlFunctionId
	"highlight default link stl11Template		stlTemplate
	highlight default link stl11TypeId			stlTypeId
endif

" highlighting of C++14 STL changes
if exists("cpp_no_cpp14")
	highlight default link stl14ClassId		stlError
else
	highlight default link stl14ClassId		stlClassId
endif

" deprecated & removed functionality
if exists("cpp_no_cpp14") && exists("cpp_no_cpp17")
	highlight default link stl14DepFunctionId stlFunctionId
else
	highlight default link stl14DepFunctionId stlError
endif
"}}}

"================================================================
" I initially copied this from https://github.com/Mizuchi/STL-Syntax. I'm only using it to point out some STL functionality I may miss in my own file.
"================================================================
