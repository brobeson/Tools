" Vim syntax file
" Language:     Catch2 test framework
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:  2019 May 19
"
" Quit if Bosot syntax is already loaded.
"if exists('b:boost_syntax_loaded')
"    finish
"endif

" TODO Add the built in matchers, generators

syntax keyword catchMacro
      \ AND_THEN
      \ AND_WHEN
      \ ANON_TEST_CASE
      \ CAPTURE
      \ CATCH_CONFIG_EXTERNAL_INTERFACES
      \ CATCH_CONFIG_MAIN
      \ CATCH_CONFIG_RUNNER
      \ CATCH_CONFIG_RUNTIME_STATIC_REQUIRE
      \ CATCH_REGISTER_LISTENER
      \ CATCH_REGISTER_TAG_ALIAS
      \ CHECK
      \ CHECK_FALSE
      \ CHECK_NOFAIL
      \ CHECK_NOTHROW
      \ CHECK_THAT
      \ CHECK_THROWS
      \ CHECK_THROWS_AS
      \ CHECK_THROWS_MATCHES
      \ CHECK_THROWS_WITH
      \ CHECKED_ELSE
      \ CHECKED_IF
      \ DYNAMIC_SECTION
      \ FAIL
      \ FAIL_CHECK
      \ GENERATE
      \ GENERATE_COPY
      \ GENERATE_REF
      \ GIVEN
      \ INFO
      \ METHOD_AS_TEST_CASE
      \ REGISTER_TEST_CASE
      \ REQUIRE
      \ REQUIRE_FALSE
      \ REQUIRE_NOTHROW
      \ REQUIRE_THAT
      \ REQUIRE_THROWS
      \ REQUIRE_THROWS_AS
      \ REQUIRE_THROWS_MATCHES
      \ REQUIRE_THROWS_WITH
      \ SCENARIO
      \ SECTION
      \ STATIC_REQUIRE
      \ SUCCEED
      \ TEMPLATE_PRODUCT_TEST_CASE
      \ TEMPLATE_PRODUCT_TEST_CASE_METHOD
      \ TEMPLATE_TEST_CASE
      \ TEMPLATE_TEST_CASE_METHOD
      \ TEST_CASE
      \ THEN
      \ UNSCOPED_INFO
      \ WARN
      \ WHEN

highlight default link catchMacro macro

"let b:boost_syntax_loaded = 1
