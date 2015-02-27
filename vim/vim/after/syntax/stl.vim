" Vim syntax file
" Language:		C++ STL
" Maintainer:	brobeson (http://github.com/brobeson/Tools)
" Last Change:	17 December 2014

" use this variable to control whether object methods should be
" highlighted.
let stl_highlight_members = 1
"let cpp_no_cpp11 = 1
"let cpp_no_cpp14 = 1
"let cpp_no_cpp17 = 1

syntax keyword stlNamespaceId contained std

" classes {{{
syntax keyword stlClassId	contained basic_string
syntax keyword stlClassId	contained char_traits
syntax keyword stlClassId	contained deque
syntax keyword stlClassId	contained list
syntax keyword stlClassId	contained map
syntax keyword stlClassId	contained mbstate_t
syntax keyword stlClassId	contained multimap
syntax keyword stlClassId	contained multiset
syntax keyword stlClassId	contained priority_queue
syntax keyword stlClassId	contained queue
syntax keyword stlClassId	contained set
syntax keyword stlClassId	contained stack
syntax keyword stlClassId	contained value_compare
syntax keyword stlClassId	contained vector
syntax keyword stlClassId	contained wctrans_t
syntax keyword stlClassId	contained wctype_t
syntax keyword stlClassId	contained wint_t
syntax match   stlClass		/std::\(basic_string\|char_traits\|deque\|list\|map\|mbstate_t\|multimap\|multiset\|priority_queue\|queue\|set\|stack\|vector\|wctrans_t\|wctype_t\|wint_t\)/ contains=stlNamespaceId,stlClassId
syntax match   stlClass		/::value_compare/ contains=stlClassId

" added in C++11
if !exists("cpp_no_cpp11")
	syntax keyword stlClassId	contained array
	syntax keyword stlClassId	contained adopt_lock_t
	syntax keyword stlClassId	contained condition_variable
	syntax keyword stlClassId	contained condition_variable_any
	syntax keyword stlClassId	contained defer_lock_t
	syntax keyword stlClassId	contained forward_list
	syntax keyword stlClassId	contained future
	syntax keyword stlClassId	contained future_error
	syntax keyword stlClassId	contained id
	syntax keyword stlClassId	contained lock_guard
	syntax keyword stlClassId	contained mutex
	syntax keyword stlClassId	contained once_flag
	syntax keyword stlClassId	contained packaged_task
	syntax keyword stlClassId	contained promise
	syntax keyword stlClassId	contained recursive_mutex
	syntax keyword stlClassId	contained recursive_timed_mutex
	syntax keyword stlClassId	contained shared_future
	syntax keyword stlClassId	contained thread
	syntax keyword stlClassId	contained timed_mutex
	syntax keyword stlClassId	contained try_to_lock_t
	syntax keyword stlClassId	contained unique_lock
	syntax keyword stlClassId	contained unordered_map
	syntax keyword stlClassId	contained unordered_multimap
	syntax keyword stlClassId	contained unordered_multiset
	syntax keyword stlClassId	contained unordered_set
	syntax match   stlClass		/std::\(array\|adopt_lock_t\|condition_variable\|condition_variable_any\|defer_lock_t\|forward_list\|future\|future_error\|lock_guard\|mutex\|once_flag\|packaged_task\|promise\|recursive_mutex\|recursive_timed_mutex\|shared_future\|thread\(::id\)\?\|timed_mutex\|try_to_lock_t\|unique_lock\|unordered_map\|unordered_multimap\|unordered_multiset\|unordered_set\)\>/ contains=stlNamespaceId,stlClassId
endif

" added in C++14
if !exists("cpp_no_cpp14")
	syntax keyword stlClassId		contained shared_lock shared_timed_mutex
	syntax match   stlClass			/std::\(shared_lock\|shared_timed_mutex\)\>/ contains=stlNamespaceId,stlClassId
endif
" }}}

" constants {{{
syntax keyword stlConstantId	contained __STDC_UTF_16__
syntax keyword stlConstantId	contained __STDC_UTF_32__
syntax keyword stlConstantId	contained npos
syntax keyword stlConstantId	contained MB_CUR_MAX
syntax keyword stlConstantId	contained MB_LEN_MAX
syntax keyword stlConstantId	contained WCHAR_MAX
syntax keyword stlConstantId	contained WCHAR_MIN
syntax keyword stlConstantId	contained WEOF
syntax match   stlConstant		/std::\(__STDC_UTF_\(16\|32\)__\|MB_\(CUR\|LEN\)_MAX\|WCHAR_M\(AX\|IN\)\|WEOF\)\>/ contains=stlNamespaceId,stlConstantId
syntax match   stlConstant		/::npos/ contains=stlConstantId

if !exists("cpp_no_cpp11")
	syntax keyword stlConstantId	contained adopt_lock
	syntax keyword stlConstantId	contained defer_lock
	syntax keyword stlConstantId	contained try_to_lock
	syntax match   stlConstant		/std::\(adopt_lock\|defer_lock\|try_to_lock\)\>/ contains=stlNamespaceId,stlConstantId
endif
" }}}

" data members {{{
if exists("stl_highlight_members")
	" TODO why does compare(comp); highlight the comp identifier?
	syntax keyword stlMemberId	contained c comp
	syntax match   stlMember	/\(\.\|->\)c\(omp\)\?/ contains=stlMemberId
endif
" }}}

" enumerations {{{
if !exists("cpp_no_cpp11")
	syntax keyword stlEnumerationId	contained cv_status
	syntax keyword stlEnumerationId	contained future_errc
	syntax keyword stlEnumerationId	contained future_status
	syntax keyword stlEnumerationId	contained launch
	syntax keyword stlEnumeratorId	contained async
	syntax keyword stlEnumeratorId	contained broken_promise
	syntax keyword stlEnumeratorId	contained deferred
	syntax keyword stlEnumeratorId	contained future_already_retrieved
	syntax keyword stlEnumeratorId	contained no_state
	syntax keyword stlEnumeratorId	contained no_timeout
	syntax keyword stlEnumeratorId	contained promise_already_satisfied
	syntax keyword stlEnumeratorId	contained ready
	syntax keyword stlEnumeratorId	contained timeout
	syntax match   stlEnumeration	/std::cv_status\(::no_timeout\|::timeout\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
	syntax match   stlEnumeration	/std::future_errc\(::broken_promise\|::future_already_retrieved\|::promise_already_satisfied\|::no_state\)\?\>/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
	syntax match   stlEnumeration	/std::future_status\(::deferred\|::ready\|::timeout\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
	syntax match   stlEnumeration	/std::launch\(::async\|::deferred\)\?/ contains=stlNamespaceId,stlEnumerationId,stlEnumeratorId
endif
" }}}

" free & static functions {{{
syntax keyword stlFunctionId	contained accumulate
syntax keyword stlFunctionId	contained adjacent_difference
syntax keyword stlFunctionId	contained adjacent_find
syntax keyword stlFunctionId	contained atof
syntax keyword stlFunctionId	contained atoi
syntax keyword stlFunctionId	contained atol
syntax keyword stlFunctionId	contained atoll
syntax keyword stlFunctionId	contained binary_search
syntax keyword stlFunctionId	contained bsearch
syntax keyword stlFunctionId	contained btowc
syntax keyword stlFunctionId	contained copy
syntax keyword stlFunctionId	contained copy_backward
syntax keyword stlFunctionId	contained count
syntax keyword stlFunctionId	contained count_if
syntax keyword stlFunctionId	contained eof
syntax keyword stlFunctionId	contained eq
syntax keyword stlFunctionId	contained eq_int_type
syntax keyword stlFunctionId	contained equal
syntax keyword stlFunctionId	contained equal_range
syntax keyword stlFunctionId	contained fill
syntax keyword stlFunctionId	contained fill_n
syntax keyword stlFunctionId	contained find
syntax keyword stlFunctionId	contained find_end
syntax keyword stlFunctionId	contained find_first_of
syntax keyword stlFunctionId	contained find_if
syntax keyword stlFunctionId	contained for_each
syntax keyword stlFunctionId	contained generate
syntax keyword stlFunctionId	contained generate_n
syntax keyword stlFunctionId	contained includes
syntax keyword stlFunctionId	contained inner_product
syntax keyword stlFunctionId	contained inplace_merge
syntax keyword stlFunctionId	contained isalnum
syntax keyword stlFunctionId	contained isalpha
syntax keyword stlFunctionId	contained iscntrl
syntax keyword stlFunctionId	contained isdigit
syntax keyword stlFunctionId	contained isgraph
syntax keyword stlFunctionId	contained islower
syntax keyword stlFunctionId	contained isprint
syntax keyword stlFunctionId	contained ispunct
syntax keyword stlFunctionId	contained isspace
syntax keyword stlFunctionId	contained isupper
syntax keyword stlFunctionId	contained iswalnum
syntax keyword stlFunctionId	contained iswalpha
syntax keyword stlFunctionId	contained iswcntrl
syntax keyword stlFunctionId	contained iswctype
syntax keyword stlFunctionId	contained iswdigit
syntax keyword stlFunctionId	contained iswgraph
syntax keyword stlFunctionId	contained iswlower
syntax keyword stlFunctionId	contained iswprint
syntax keyword stlFunctionId	contained iswpunct
syntax keyword stlFunctionId	contained iswspace
syntax keyword stlFunctionId	contained iswupper
syntax keyword stlFunctionId	contained iswxdigit
syntax keyword stlFunctionId	contained isxdigit
syntax keyword stlFunctionId	contained iter_swap
syntax keyword stlFunctionId	contained lexicographical_compare
syntax keyword stlFunctionId	contained lower_bound
syntax keyword stlFunctionId	contained lt
syntax keyword stlFunctionId	contained max
syntax keyword stlFunctionId	contained max_element
syntax keyword stlFunctionId	contained make_heap
syntax keyword stlFunctionId	contained mblen
syntax keyword stlFunctionId	contained mbrlen
syntax keyword stlFunctionId	contained mbrtowc
syntax keyword stlFunctionId	contained mbsinit
syntax keyword stlFunctionId	contained mbsrtowcs
syntax keyword stlFunctionId	contained mbstowcs
syntax keyword stlFunctionId	contained mbtowc
syntax keyword stlFunctionId	contained memchr
syntax keyword stlFunctionId	contained memcmp
syntax keyword stlFunctionId	contained memcpy
syntax keyword stlFunctionId	contained memmove
syntax keyword stlFunctionId	contained memset
syntax keyword stlFunctionId	contained merge
syntax keyword stlFunctionId	contained min
syntax keyword stlFunctionId	contained min_element
syntax keyword stlFunctionId	contained mismatch
syntax keyword stlFunctionId	contained move
syntax keyword stlFunctionId	contained next_permutation
syntax keyword stlFunctionId	contained not_eof
syntax keyword stlFunctionId	contained nth_element
syntax keyword stlFunctionId	contained partial_sort
syntax keyword stlFunctionId	contained partial_sort_copy
syntax keyword stlFunctionId	contained partial_sum
syntax keyword stlFunctionId	contained partition
syntax keyword stlFunctionId	contained pop_heap
syntax keyword stlFunctionId	contained prev_permutation
syntax keyword stlFunctionId	contained push_heap
syntax keyword stlFunctionId	contained qsort
syntax keyword stlFunctionId	contained remove
syntax keyword stlFunctionId	contained remove_copy
syntax keyword stlFunctionId	contained remove_copy_if
syntax keyword stlFunctionId	contained remove_if
syntax keyword stlFunctionId	contained replace
syntax keyword stlFunctionId	contained replace_copy
syntax keyword stlFunctionId	contained replace_copy_if
syntax keyword stlFunctionId	contained replace_if
syntax keyword stlFunctionId	contained reverse
syntax keyword stlFunctionId	contained reverse_copy
syntax keyword stlFunctionId	contained rotate
syntax keyword stlFunctionId	contained rotate_copy
syntax keyword stlFunctionId	contained search
syntax keyword stlFunctionId	contained search_n
syntax keyword stlFunctionId	contained set_difference
syntax keyword stlFunctionId	contained set_intersection
syntax keyword stlFunctionId	contained set_symmetric_difference
syntax keyword stlFunctionId	contained set_union
syntax keyword stlFunctionId	contained sort
syntax keyword stlFunctionId	contained sort_heap
syntax keyword stlFunctionId	contained stable_partition
syntax keyword stlFunctionId	contained stable_sort
syntax keyword stlFunctionId	contained stod
syntax keyword stlFunctionId	contained stof
syntax keyword stlFunctionId	contained stoi
syntax keyword stlFunctionId	contained stol
syntax keyword stlFunctionId	contained stoll
syntax keyword stlFunctionId	contained stoul
syntax keyword stlFunctionId	contained stold
syntax keyword stlFunctionId	contained stoull
syntax keyword stlFunctionId	contained strcat
syntax keyword stlFunctionId	contained strchr
syntax keyword stlFunctionId	contained strcmp
syntax keyword stlFunctionId	contained strcoll
syntax keyword stlFunctionId	contained strcpy
syntax keyword stlFunctionId	contained strcspn
syntax keyword stlFunctionId	contained strerror
syntax keyword stlFunctionId	contained strlen
syntax keyword stlFunctionId	contained strncat
syntax keyword stlFunctionId	contained strncmp
syntax keyword stlFunctionId	contained strncpy
syntax keyword stlFunctionId	contained strpbrk
syntax keyword stlFunctionId	contained strrchr
syntax keyword stlFunctionId	contained strspn
syntax keyword stlFunctionId	contained strstr
syntax keyword stlFunctionId	contained strtod
syntax keyword stlFunctionId	contained strtof
syntax keyword stlFunctionId	contained strtok
syntax keyword stlFunctionId	contained strtol
syntax keyword stlFunctionId	contained strtold
syntax keyword stlFunctionId	contained strtoll
syntax keyword stlFunctionId	contained strtoul
syntax keyword stlFunctionId	contained strtoull
syntax keyword stlFunctionId	contained strxfrm
syntax keyword stlFunctionId	contained swap
syntax keyword stlFunctionId	contained swap_ranges
syntax keyword stlFunctionId	contained to_char_type
syntax keyword stlFunctionId	contained to_int_type
syntax keyword stlFunctionId	contained to_string
syntax keyword stlFunctionId	contained to_wstring
syntax keyword stlFunctionId	contained tolower
syntax keyword stlFunctionId	contained toupper
syntax keyword stlFunctionId	contained towctrans
syntax keyword stlFunctionId	contained towlower
syntax keyword stlFunctionId	contained towupper
syntax keyword stlFunctionId	contained transform
syntax keyword stlFunctionId	contained unique
syntax keyword stlFunctionId	contained unique_copy
syntax keyword stlFunctionId	contained upper_bound
syntax keyword stlFunctionId	contained wcrtomb
syntax keyword stlFunctionId	contained wcscat
syntax keyword stlFunctionId	contained wcschr
syntax keyword stlFunctionId	contained wcscmp
syntax keyword stlFunctionId	contained wcscoll
syntax keyword stlFunctionId	contained wcscpy
syntax keyword stlFunctionId	contained wcscspn
syntax keyword stlFunctionId	contained wcslen
syntax keyword stlFunctionId	contained wcsncat
syntax keyword stlFunctionId	contained wcsncmp
syntax keyword stlFunctionId	contained wcsncpy
syntax keyword stlFunctionId	contained wcspbrk
syntax keyword stlFunctionId	contained wcsrchr
syntax keyword stlFunctionId	contained wcsrtombs
syntax keyword stlFunctionId	contained wcsspn
syntax keyword stlFunctionId	contained wcsstr
syntax keyword stlFunctionId	contained wcstod
syntax keyword stlFunctionId	contained wcstof
syntax keyword stlFunctionId	contained wcstok
syntax keyword stlFunctionId	contained wcstol
syntax keyword stlFunctionId	contained wcstold
syntax keyword stlFunctionId	contained wcstoll
syntax keyword stlFunctionId	contained wcstombs
syntax keyword stlFunctionId	contained wcstoul
syntax keyword stlFunctionId	contained wcstoull
syntax keyword stlFunctionId	contained wcsxfrm
syntax keyword stlFunctionId	contained wctob
syntax keyword stlFunctionId	contained wctomb
syntax keyword stlFunctionId	contained wctrans
syntax keyword stlFunctionId	contained wctype
syntax keyword stlFunctionId	contained wmemchr
syntax keyword stlFunctionId	contained wmemcmp
syntax keyword stlFunctionId	contained wmemcpy
syntax keyword stlFunctionId	contained wmemmove
syntax keyword stlFunctionId	contained wmemset
syntax match   stlFunction		/std::\(btowc\|mb\(len\|rlen\|rtowc\|sinit\|srtowcs\|stowcs\|towc\)\|wc\(rtomb\|srtombs\|stombs\|tob\|tomb\)\)\>/ contains=stlNamespaceId,stlFunctionId
syntax match   stlFunction		/std::wc\(s\(cat\|chr\|cmp\|coll\|cpy\|cspn\|len\|ncat\|ncmp\|ncpy\|pbrk\|rchr\|rtombs\|spn\|str\|tod\|tof\|tok\|tol\|told\|toll\|tombs\|toul\|toull\|xfrm\)\|trans\|type\)\>/ contains=stlNamespaceId,stlFunctionId
syntax match   stlFunction		/std::\(accumulate\|adjacent_difference\|adjacent_find\|ato\(f\|i\|l\|ll\)\|binary_search\|bsearch\|copy\|copy_backward\|count\|count_if\|equal\|equal_range\|fill\|fill_n\|find\|find_end\|find_first_of\|find_if\|for_each\|generate\|generate_n\|includes\|inner_product\|inplace_merge\|isw\?\(alnum\|alpha\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\)\|iswctype\|iter_swap\|lexicographical_compare\|lower_bound\|max\|max_element\|make_heap\|w\?mem\(chr\|cmp\|cpy\|move\|set\)\|merge\|min\|min_element\|mismatch\|next_permutation\|nth_element\|partial_sort\|partial_sort_copy\|partial_sum\|partition\|pop_heap\|prev_permutation\|push_heap\|qsort\|remove\|remove_copy\|remove_copy_if\|remove_if\|replace\|replace_copy\|replace_copy_if\|replace_if\|reverse\|reverse_copy\|rotate\|rotate_copy\|search\|search_n\|set_difference\|set_intersection\|set_symmetric_difference\|set_union\|sort\|sort_heap\|stable_partition\|stable_sort\|sto\(i\|l\|ll\|ul\|ull\|f\|d\|ld\)\|str\(cat\|chr\|cmp\|coll\|cpy\|cspn\|error\|len\|ncat\|ncmp\|ncpy\|pbrk\|rchr\|spn\|str\|to\(d\|f\|k\|l\|ld\|ll\|ul\|ull\)\|xfrm\)\|swap\|swap_ranges\|to\(_string\|_wstring\|wctrans\|w\?lower\|w\?upper\)\|transform\|unique\|unique_copy\|upper_bound\|\)\>/ contains=stlNamespaceId,stlFunctionId
syntax match   stlFunction		/::\(assign\|compare\|copy\|eof\|eq\|eq_int_type\|find\|length\|lt\|move\|not_eof\|to_char_type\|to_int_type\)\>/ contains=stlMethodId,stlFunctionId

" C++11
if !exists("cpp_no_cpp11")
	syntax keyword stlFunctionId	contained all_of
	syntax keyword stlFunctionId	contained any_of
	syntax keyword stlFunctionId	contained async
	syntax keyword stlFunctionId	contained c16rtomb
	syntax keyword stlFunctionId	contained c32rtomb
	syntax keyword stlFunctionId	contained call_once
	syntax keyword stlFunctionId	contained copy_if
	syntax keyword stlFunctionId	contained copy_n
	syntax keyword stlFunctionId	contained find_if_not
	syntax keyword stlFunctionId	contained future_category
	syntax keyword stlFunctionId	contained get
	syntax keyword stlFunctionId	contained get_id
	syntax keyword stlFunctionId	contained hardware_concurrency
	syntax keyword stlFunctionId	contained hash
	syntax keyword stlFunctionId	contained iota
	syntax keyword stlFunctionId	contained is_heap
	syntax keyword stlFunctionId	contained is_heap_until
	syntax keyword stlFunctionId	contained is_partitioned
	syntax keyword stlFunctionId	contained is_permutation
	syntax keyword stlFunctionId	contained is_sorted
	syntax keyword stlFunctionId	contained is_sorted_until
	syntax keyword stlFunctionId	contained isblank
	syntax keyword stlFunctionId	contained iswblank
	syntax keyword stlFunctionId	contained lock
	syntax keyword stlFunctionId	contained make_error_code
	syntax keyword stlFunctionId	contained make_error_condition
	syntax keyword stlFunctionId	contained mbrtoc16
	syntax keyword stlFunctionId	contained mbrtoc32
	syntax keyword stlFunctionId	contained minmax
	syntax keyword stlFunctionId	contained minmax_element
	syntax keyword stlFunctionId	contained move
	syntax keyword stlFunctionId	contained move_backward
	syntax keyword stlFunctionId	contained none_of
	syntax keyword stlFunctionId	contained notify_all_at_thread_exit
	syntax keyword stlFunctionId	contained partition_copy
	syntax keyword stlFunctionId	contained partition_point
	syntax keyword stlFunctionId	contained shuffle
	syntax keyword stlFunctionId	contained sleep_for
	syntax keyword stlFunctionId	contained sleep_until
	syntax keyword stlFunctionId	contained strtoimax
	syntax keyword stlFunctionId	contained strtoumax
	syntax keyword stlFunctionId	contained swap
	syntax keyword stlFunctionId	contained try_lock
	syntax keyword stlFunctionId	contained yield
	syntax keyword stlFunctionId	contained wcstoimax
	syntax keyword stlFunctionId	contained wcstoumax
	syntax match   stlFunction		/\<std::\(c\(16\|32\)rtomb\|mbrtoc\(16\|32\)\)\>/ contains=stlNamespaceId,stlFunctionId
	syntax match   stlFunction		/\<std::\(all_of\|any_of\|async\|call_once\|copy_if\|copy_n\|find_if_not\|future_category\|get\|get_id\|hash\|iota\|is\(_heap\|_heap_until\|_partitioned\|_permutation\|_sorted\|_sorted_until\|w\?blank\)\|lock\|make_error_code\|make_error_condition\|minmax\|minmax_element\|move\|move_backward\|none_of\|notify_all_at_thread_exit\|partition_copy\|partition_point\|shuffle\|sleep_for\|sleep_until\|strto[iu]max\|swap\|try_lock\|wcsto[iu]max\|yield\)\>/ contains=stlNamespaceId,stlFunctionId
	syntax match   stlFunction		/\<std::thread::hardware_concurrency/ contains=stlNamespaceId,stlClassId,stlFunctionId
endif

" deprecated in C++14
if exists("cpp_no_cpp14") && exists("cpp_no_cpp17")
	syntax keyword stlFunctionId	contained random_shuffle
	syntax match   stlFunction		/\<std::random_shuffle\>/ contains=stlNamespaceId,stlFunctionId
endif
" }}}

" methods {{{
if exists("stl_highlight_members")
	syntax keyword stlMethodId	contained append
	syntax keyword stlMethodId	contained assign
	syntax keyword stlMethodId	contained at
	syntax keyword stlMethodId	contained back
	syntax keyword stlMethodId	contained begin
	syntax keyword stlMethodId	contained c_str
	syntax keyword stlMethodId	contained capacity
	syntax keyword stlMethodId	contained cbegin
	syntax keyword stlMethodId	contained cend
	syntax keyword stlMethodId	contained clear
	syntax keyword stlMethodId	contained compare
	syntax keyword stlMethodId	contained copy
	syntax keyword stlMethodId	contained count
	syntax keyword stlMethodId	contained crbegin
	syntax keyword stlMethodId	contained crend
	syntax keyword stlMethodId	contained data
	syntax keyword stlMethodId	contained empty
	syntax keyword stlMethodId	contained end
	syntax keyword stlMethodId	contained equal_range
	syntax keyword stlMethodId	contained erase
	syntax keyword stlMethodId	contained find
	syntax keyword stlMethodId	contained find_first_not_of
	syntax keyword stlMethodId	contained find_first_of
	syntax keyword stlMethodId	contained find_last_not_of
	syntax keyword stlMethodId	contained find_last_of
	syntax keyword stlMethodId	contained front
	syntax keyword stlMethodId	contained get_allocator
	syntax keyword stlMethodId	contained insert
	syntax keyword stlMethodId	contained key_comp
	syntax keyword stlMethodId	contained length
	syntax keyword stlMethodId	contained lower_bound
	syntax keyword stlMethodId	contained max_size
	syntax keyword stlMethodId	contained merge
	syntax keyword stlMethodId	contained pop
	syntax keyword stlMethodId	contained pop_back
	syntax keyword stlMethodId	contained pop_front
	syntax keyword stlMethodId	contained push
	syntax keyword stlMethodId	contained push_back
	syntax keyword stlMethodId	contained push_front
	syntax keyword stlMethodId	contained rbegin
	syntax keyword stlMethodId	contained remove
	syntax keyword stlMethodId	contained remove_if
	syntax keyword stlMethodId	contained rend
	syntax keyword stlMethodId	contained replace
	syntax keyword stlMethodId	contained reserve
	syntax keyword stlMethodId	contained resize
	syntax keyword stlMethodId	contained reverse
	syntax keyword stlMethodId	contained rfind
	syntax keyword stlMethodId	contained size
	syntax keyword stlMethodId	contained sort
	syntax keyword stlMethodId	contained splice
	syntax keyword stlMethodId	contained substr
	syntax keyword stlMethodId	contained swap
	syntax keyword stlMethodId	contained top
	syntax keyword stlMethodId	contained unique
	syntax keyword stlMethodId	contained upper_bound
	syntax keyword stlMethodId	contained value_comp
	syntax match   stlMethod	/\(->\|\.\)\(append\|assign\|at\|back\|begin\|c_str\|capacity\|cbegin\|cend\|clear\|compare\|copy\|count\|crbegin\|crend\|data\|empty\|end\|equal_range\|erase\|find\|find_first_not_of\|find_first_of\|find_last_not_of\|find_last_of\|front\|get_allocator\|insert\|key_comp\|length\|lower_bound\|max_size\|merge\|pop\|pop_back\|pop_front\|push\|push_back\|push_front\|rbegin\|remove\|remove_if\|rend\|replace\|reserve\|resize\|reverse\|rfind\|size\|sort\|splice\|substr\|swap\|top\|unique\|upper_bound\|value_comp\)\>/ contains=stlMethodId

	if !exists("cpp_no_cpp11")
		syntax keyword stlMethodId	contained before_begin
		syntax keyword stlMethodId	contained bucket
		syntax keyword stlMethodId	contained bucket_count
		syntax keyword stlMethodId	contained bucket_size
		syntax keyword stlMethodId	contained cbefore_begin
		syntax keyword stlMethodId	contained code
		syntax keyword stlMethodId	contained detach
		syntax keyword stlMethodId	contained emplace
		syntax keyword stlMethodId	contained emplace_after
		syntax keyword stlMethodId	contained emplace_back
		syntax keyword stlMethodId	contained emplace_front
		syntax keyword stlMethodId	contained emplace_hint
		syntax keyword stlMethodId	contained erase_after
		syntax keyword stlMethodId	contained fill
		syntax keyword stlMethodId	contained get
		syntax keyword stlMethodId	contained get_future
		syntax keyword stlMethodId	contained get_id
		syntax keyword stlMethodId	contained hash_function
		syntax keyword stlMethodId	contained insert_after
		syntax keyword stlMethodId	contained join
		syntax keyword stlMethodId	contained joinable
		syntax keyword stlMethodId	contained key_eq
		syntax keyword stlMethodId	contained load_factor
		syntax keyword stlMethodId	contained lock
		syntax keyword stlMethodId	contained max_bucket_count
		syntax keyword stlMethodId	contained max_load_factor
		syntax keyword stlMethodId	contained make_ready_at_thread_exit
		syntax keyword stlMethodId	contained mutex
		syntax keyword stlMethodId	contained native_handle
		syntax keyword stlMethodId	contained notify_all
		syntax keyword stlMethodId	contained notify_one
		syntax keyword stlMethodId	contained owns_lock
		syntax keyword stlMethodId	contained rehash
		syntax keyword stlMethodId	contained release
		syntax keyword stlMethodId	contained reset
		syntax keyword stlMethodId	contained set_exception
		syntax keyword stlMethodId	contained set_exception_at_thread_exit
		syntax keyword stlMethodId	contained set_value
		syntax keyword stlMethodId	contained set_value_at_thread_exit
		syntax keyword stlMethodId	contained share
		syntax keyword stlMethodId	contained shrink_to_fit
		syntax keyword stlMethodId	contained splice_after
		syntax keyword stlMethodId	contained try_lock
		syntax keyword stlMethodId	contained try_lock_for
		syntax keyword stlMethodId	contained try_lock_until
		syntax keyword stlMethodId	contained unlock
		syntax keyword stlMethodId	contained valid
		syntax keyword stlMethodId	contained wait
		syntax keyword stlMethodId	contained wait_for
		syntax keyword stlMethodId	contained wait_until
		syntax keyword stlMethodId	contained what
		syntax match   stlMethod	/\(->\|\.\)\(before_begin\|bucket\|bucket_count\|bucket_size\|cbefore_begin\|code\|detach\|emplace\|emplace_after\|emplace_back\|emplace_front\|emplace_hint\|erase_after\|fill\|get\|get_future\|get_id\|hash_function\|insert_after\|join\|joinable\|key_eq\|load_factor\|lock\|make_ready_at_thread_exit\|max_bucket_count\|max_load_factor\|mutex\|native_handle\|notify_all\|notify_one\|owns_lock\|rehash\|release\|reset\|set_exception\|set_exception_at_thread_exit\|set_value\|set_value_at_thread_exit\|share\|shrink_to_fit\|splice_after\|try_lock\|try_lock_for\|try_lock_until\|unlock\|valid\|wait\|wait_for\|wait_until\|what\)\>/ contains=stlMethodId
	endif

	if !exists("cpp_no_cpp14")
		syntax keyword stlMethodId	contained lock_shared
		syntax keyword stlMethodId	contained try_lock_shared
		syntax keyword stlMethodId	contained try_lock_shared_for
		syntax keyword stlMethodId	contained try_lock_shared_until
		syntax keyword stlMethodId	contained unlock_shared
		syntax match   stlMethod	/\(->\|\.\)\(lock_shared\|try_lock_shared\|try_lock_shared_for\|try_lock_shared_until\|unlock_shared\)\>/ contains=stlMethodId
	endif

	if !exists("cpp_no_cpp17")
		syntax keyword stlMethodId	contained insert_or_assign
		syntax keyword stlMethodId	contained try_emplace
		syntax match   stlMethod	/\(->\|\.\)\(insert_or_assign\|try_emplace\)\>/ contains=stlMethodId
	endif
endif
" }}}

" typedefs {{{
syntax keyword stlTypeId	contained allocator_type
syntax keyword stlTypeId	contained char_type
syntax keyword stlTypeId	contained const_iterator
syntax keyword stlTypeId	contained const_pointer
syntax keyword stlTypeId	contained const_reference
syntax keyword stlTypeId	contained const_reverse_iterator
syntax keyword stlTypeId	contained container_type
syntax keyword stlTypeId	contained difference_type
syntax keyword stlTypeId	contained first_argument_type
syntax keyword stlTypeId	contained int_type
syntax keyword stlTypeId	contained iterator
syntax keyword stlTypeId	contained key_compare
syntax keyword stlTypeId	contained key_type
syntax keyword stlTypeId	contained mapped_type
syntax keyword stlTypeId	contained off_type
syntax keyword stlTypeId	contained pointer
syntax keyword stlTypeId	contained pos_type
syntax keyword stlTypeId	contained reference
syntax keyword stlTypeId	contained result_type
syntax keyword stlTypeId	contained reverse_iterator
syntax keyword stlTypeId	contained second_argument_type
syntax keyword stlTypeId	contained size_type
syntax keyword stlTypeId	contained state_type
syntax keyword stlTypeId	contained string
syntax keyword stlTypeId	contained traits_type
syntax keyword stlTypeId	contained value_type
syntax keyword stlTypeId	contained u16string
syntax keyword stlTypeId	contained u32string
syntax keyword stlTypeId	contained wstring
syntax match   stlType		/::\(allocator_type\|char_type\|const_iterator\|const_pointer\|const_reference\|const_reverse_iterator\|container_type\|difference_type\|int_type\|iterator\|key_compare\|key_type\|mapped_type\|off_type\|pointer\|pos_type\|reference\|reverse_iterator\|size_type\|state_type\|traits_type\|value_type\)/ contains=stlTypeId
syntax match   stlType		/::value_compare::\(first_argument_type\|result_type\|second_argument_type\)\>/ contains=stlClassId,stlTypeId
syntax match   stlType		/std::\(u16\|u32\|w\)\?string/ contains=stlNamespaceId,stlTypeId

if !exists("cpp_no_cpp11")
	syntax keyword stlTypeId	contained const_local_iterator
	syntax keyword stlTypeId	contained hasher
	syntax keyword stlTypeId	contained key_equal
	syntax keyword stlTypeId	contained local_iterator
	syntax keyword stlTypeId	contained mutex_type
	syntax keyword stlTypeId	contained native_handle_type
	syntax match   stlType		/::\(const_local_iterator\|hasher\|key_equal\|local_iterator\)/ contains=stlTypeId
	syntax match   stlType		/std::\(\(condition_variable\|mutex\|thread\)::native_handle_type\|\(lock_guard\|unique_lock\)::mutex_type\)\>/ contains=stlNamespaceId,stlClassId,stlTypeId
endif

if !exists("cpp_no_cpp14")
	syntax keyword stlTypeId	contained mutex_type;
	syntax match   stlType		/std::shared_lock::mutex_type\>/ contains=stlNamespaceId,stlClassId,stlTypeId
endif
" }}}

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
"		if exists("stl_highlight_members")
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
"		if exists("stl_highlight_members")
"			syntax match stlMethod "\.\(expired\|get_deleter\|lock\|owner_before\|release\|reset\|shared_from_this\|unique\|use_count\)"
"		endif
"
"		" allocators
"		syntax match stlTemplate "std::\(allocator\|allocator_traits\|uses_allocator\|scoped_allocator_adaptor\)"
"		syntax match stlClass    "std::allocator_arg_t"
"		syntax match stlConstant "std::allocator_arg"
"		syntax match stlFunction "std::allocator_traits::\(allocate\|construct\|deallocate\|destroy\|max_size\|select_on_container_copy_construction\)"
"		syntax match stlConstant "std::uses_allocator::value"
"		if exists("stl_highlight_members")
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

" TODO	{{{
" iterators 
" numerics 
" input/output 
" localizations 
" regular expressions 
" atomic operations 
" "" s operator (from C++ 14)

" std::uses_allocator	class template
" std::is_error_code_enum class template
" }}}

" highlighting {{{
highlight default link stlClassId		Structure
highlight default link stlConstantId	Constant
highlight default link stlEnumerationId	Structure
highlight default link stlEnumeratorId	Constant
highlight default link stlError			Error
highlight default link stlFunctionId	Function
highlight default link stlMemberId		Identifier
highlight default link stlMethodId		Function
highlight default link stlNamespaceId	Structure
highlight default link stlTypeId		Typedef
"}}}

