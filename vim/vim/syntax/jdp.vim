" TODO
" - individual steps
" - numbers
" - parameters
" - can comments be before the leading pipeline block?
" - determine conflicting keywords
" - add steps from other plugins
" - add Jenkins environment variables

if exists("b:current_syntax")
   finish
endif
let s:keepcpo= &cpo
set cpo&vim

syntax region jp_fold start="{" end="}" transparent fold

" comments {{{
syntax keyword jp_todo    contained TODO FIXME XXX BUG HACK
syntax region  jp_comment start="//" skip="\\$" end="$" keepend contains=jp_todo,@Spell
syntax region  jp_comment start="/\*" end="\*/" contains=jp_todo,@Spell
  "contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError,@Spell
" }}}

" possible common mistakes
syntax match jp_semicolon /;/

" variable reference: ${foo}
syntax region  jp_variable_reference start="${" end="}" oneline contains=jp_built_in

" strings {{{
syntax match jp_special display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syntax region jp_one_line_string start=/'/ skip=/\\'/ end=/'/ contains=jp_special
syntax region jp_one_line_string start=/"/ skip=/\\"/ end=/"/ contains=jp_special,jp_variable_reference
syntax region jp_multi_line_string start=/'''/ end=/'''/ contains=jp_special
syntax region jp_multi_line_string start=/"""/ end=/"""/ contains=jp_special,jp_variable_reference
" }}}

" the required leading pipeline
syntax keyword jp_pipeline pipeline

" boolean constants
syntax keyword jp_boolean true false

" the available sections, directives, and parallel
syntax keyword jp_section agent post stages steps
syntax keyword jp_directive environment options parameters triggers stage tools input when
syntax keyword jp_parallel parallel

syntax keyword jp_parameter_options booleanParam

" all the available steps {{{
syntax keyword jp_block_step
    \   dir
    \   node
    \   script
    \   warnError
syntax keyword jp_step
    \   archive
    \   archiveArtifacts
    \   bat
    \   catchError
    \   checkout
    \   cleanWs
    \   deleteDir
    \   echo
    \   error
    \   fileExists
    \   getContext
    \   isUnix
    \   mail
    \   powershell
    \   publishCoverage
    \   pwd
    \   readFile
    \   retry
    \   sh
    \   sleep
    \   stash
    \   timeout
    \   tool
    \   unarchive
    \   unstash
    \   waitUntil
    \   withContext
    \   withEnv
    \   wrap
    \   writeFile
    \   ws
    \   xunit
    "\   script
" }}}

" options {{{
syntax keyword jp_option
    \   buildDiscarder
    \   checkoutToSubdirectory
    \   disableConcurrentBuilds
    \   overrideIndexTriggers
    \   retry
    \   skipDefaultCheckout
    \   skipStagesAfterUnstable
    \   timeout
    \   timestamps
" }}}

" conditions available for the post section
syntax keyword jp_condition
  \ aborted
  \ always
  \ changed
  \ cleanup
  \ expression
  \ failure
  \ return
  \ success
  \ unstable

" various step parameters {{{
syntax keyword jp_parameter
    \   adapters
    \   any
    \   catchInterruptions
    \   customWorkspace
    \   defaultValue
    \   deleteOutputFiles
    \   description
    \   docker
    \   dockerfile
    \   failIfNotNew
    \   label
    \   message
    \   name
    \   none
    \   notFailBuild
    \   pattern
    \   reuseNode
    \   returnStdout
    \   scm
    \   skipNoTestFiles
    \   sourceFileResolver
    \   stopProcessingIfError
syntax match jp_parameter /script:/
" }}}

" built-in variables
syntax match jp_built_in /\(env\.\)\?\(CHANGE_ID\|WORKSPACE\)/


highlight default link jp_built_in macro
highlight default link jp_parameter identifier
highlight default link jp_one_line_string string
highlight default link jp_multi_line_string string
highlight default link jp_condition structure
highlight default link jp_option identifier
highlight default link jp_boolean boolean
highlight default link jp_comment comment
highlight default link jp_variable_reference identifier
highlight default link jp_pipeline structure
highlight default link jp_section structure
highlight default link jp_directive structure
highlight default link jp_parallel structure
highlight default link jp_semicolon error
highlight default link jp_todo todo
highlight default link jp_special SpecialChar
highlight default link jp_step statement
highlight default link jp_block_step structure
highlight default link jp_parameter_options structure

let b:current_syntax = "jenkins-pipeline"
let &cpo = s:keepcpo
unlet s:keepcpo
