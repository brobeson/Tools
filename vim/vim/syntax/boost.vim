" Vim syntax file
" Language:     Boost test framework
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:  2019 May 19
"
" Quit if Bosot syntax is already loaded.
"if exists('b:boost_syntax_loaded')
"    finish
"endif

syntax keyword boostMacro
      \ BOOST_AUTO_TEST_CASE
      \ BOOST_AUTO_TEST_CASE_TEMPLATE
      \ BOOST_AUTO_TEST_SUITE
      \ BOOST_AUTO_TEST_SUITE_END
      \ BOOST_DATA_TEST_CASE
      \ BOOST_PARAM_TEST_CASE
      \ BOOST_TEST_CASE
      \ BOOST_TEST_CASE_TEMPLATE
      \ BOOST_TEST_CASE_TEMPLATE_FUNCTION
      \ BOOST_DATA_TEST_CASE_F
      \ BOOST_TEST_SUITE
      \ BOOST_AUTO_TEST_SUITE
      \ BOOST_AUTO_TEST_SUITE_END
      \ BOOST_FIXTURE_TEST_CASE
      \ BOOST_FIXTURE_TEST_SUITE
      \ BOOST_GLOBAL_FIXTURE
      \ BOOST_TEST_GLOBAL_FIXTURE
      \ BOOST_TEST_DECORATOR
      \ BOOST_TESTBOOST_<level>
      \ BOOST_WARN
      \ BOOST_WARN_BITWISE_EQUAL
      \ BOOST_WARN_EQUAL
      \ BOOST_WARN_EQUAL_COLLECTIONS
      \ BOOST_WARN_CLOSE
      \ BOOST_WARN_CLOSE_FRACTION
      \ BOOST_WARN_GE
      \ BOOST_WARN_GT
      \ BOOST_WARN_LE
      \ BOOST_WARN_LT
      \ BOOST_WARN_MESSAGE
      \ BOOST_WARN_NE
      \ BOOST_WARN_PREDICATE
      \ BOOST_WARN_NO_THROW
      \ BOOST_WARN_THROW
      \ BOOST_WARN_EXCEPTION
      \ BOOST_WARN_SMALL
      \ BOOST_CHECK
      \ BOOST_CHECK_BITWISE_EQUAL
      \ BOOST_CHECK_EQUAL
      \ BOOST_CHECK_EQUAL_COLLECTIONS
      \ BOOST_CHECK_CLOSE
      \ BOOST_CHECK_CLOSE_FRACTION
      \ BOOST_CHECK_GE
      \ BOOST_CHECK_GT
      \ BOOST_CHECK_LE
      \ BOOST_CHECK_LT
      \ BOOST_CHECK_MESSAGE
      \ BOOST_CHECK_NE
      \ BOOST_CHECK_PREDICATE
      \ BOOST_CHECK_NO_THROW
      \ BOOST_CHECK_THROW
      \ BOOST_CHECK_EXCEPTION
      \ BOOST_CHECK_SMALL
      \ BOOST_REQUIRE
      \ BOOST_REQUIRE_BITWISE_EQUAL
      \ BOOST_REQUIRE_EQUAL
      \ BOOST_REQUIRE_EQUAL_COLLECTIONS
      \ BOOST_REQUIRE_CLOSE
      \ BOOST_REQUIRE_CLOSE_FRACTION
      \ BOOST_REQUIRE_GE
      \ BOOST_REQUIRE_GT
      \ BOOST_REQUIRE_LE
      \ BOOST_REQUIRE_LT
      \ BOOST_REQUIRE_MESSAGE
      \ BOOST_REQUIRE_NE
      \ BOOST_REQUIRE_PREDICATE
      \ BOOST_REQUIRE_NO_THROW
      \ BOOST_REQUIRE_THROW
      \ BOOST_REQUIRE_EXCEPTION
      \ BOOST_REQUIRE_SMALL
      \ BOOST_AUTO_TEST_CASE_EXPECTED_FAILURES
      \ BOOST_ERROR
      \ BOOST_FAIL
      \ BOOST_IS_DEFINED
      \ BOOST_TEST_TOOLS_UNDER_DEBUGGER
      \ BOOST_TEST_TOOLS_DEBUGGABLE
      \ BOOST_TEST_CHECKPOINT
      \ BOOST_TEST_PASSPOINT
      \ BOOST_TEST_MESSAGE
      \ BOOST_TEST_INFO
      \ BOOST_TEST_CONTEXT
      \ BOOST_TEST_DONT_PRINT_LOG_VALUE
      \ BOOST_TEST_MAIN
      \ BOOST_TEST_MODULE
      \ BOOST_TEST_ALTERNATIVE_INIT_API
      \ BOOST_TEST_NO_LIB
      \ BOOST_TEST_DYN_LINK
      \ BOOST_TEST_NO_MAIN
      \ BOOST_TEST_GLOBAL_CONFIGURATION
      \ BOOST_TEST_DISABLE_ALT_STACK

highlight default link boostMacro macro

"let b:boost_syntax_loaded = 1
