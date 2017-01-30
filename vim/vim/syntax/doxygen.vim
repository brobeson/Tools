" Vim syntax file
" Language:     Doxygen
" Maintainer:   Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:  2016 November 24
"
" What does this file do?
" This adds a highlight group for Doxygen commands. I'm aware of the
" doxygen.vim which ships with Vim, but that appears to do more than I want,
" and it fouls up my comment highlighting. So this file only provides a
" syntax highlighting group for the Doxygen commands. Thus, one can make the
" commands highlight differently from other parts of the comment.
"
" How to use this:
" 1. Somehow, source this file. My preference is to create
"    ~/.vim/after/syntax/cpp.vim. In that file, use the command
"    'runtime syntax/doxygen.vim'.
" 2. Add the group 'doxCommand' to the group responsible for highlighting
"    comments. For C++, in the same file that loads this syntax, add the
"    command 'syntax cluster cCommentGroup add=doxCommand'.
" 3. In your colorscheme file, add the desired highlighting for Doxygen
"    commands. 'highlight doxCommand cterm...'

" skip checking for b:current_syntax
" this syntax file is meant to be loaded by another syntax file, such as cpp.
" if b:current_syntax is checked, loading this may be skipped.

syntax match doxCommand /[\\@]\(a\(ddindex\|ddtogroup\|nchor\|rg\|ttention\|uthors\?\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(b\(rief\|ug\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(c\(allergraph\|allgraph\|ategory\|ite\|lass\|ode\|ond\|opybrief\|opydetails\|opydoc\|opyright\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(date\|def\(group\)\?\|deprecated\|details\|diafile\|dir\|docbookonly\|dontinclude\|dot\(file\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(e\(lse\(if\)\?\|m\|ndcode\|ndcond\|nddocbookonly\|nddot\|ndhtmlonly\|ndif\|ndinternal\|ndlatexonly\|ndlink\|ndmanonly\|ndmsc\|ndparblock\|ndrtfonly\|ndsecreflist\|ndverbatim\|nduml\|ndxmlonly\|num\|xample\|xception\|xtends\)\?\)\>/ contained
syntax match doxCommand /[\\@]f\$/ contained
syntax match doxCommand /[\\@]\(f\$\|f\[\|f\]\|f{\|f}\|file\|fn\)\>/ contained
syntax match doxCommand /[\\@]\(headerfile\|hidecallergraph\|hidecallgraph\|hideinitializer\|htmlinclude\|htmlonly\)\>/ contained
syntax match doxCommand /[\\@]\(idlexcept\|if\(not\)\?\|image\|implements\|include\(doc\|lineno\)\?\|ingroup\|internal\|invariant\|interface\)\>/ contained
syntax match doxCommand /[\\@]\(latexinclude\|latexonly\|li\(ne\|nk\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(mainpage\|manonly\|memberof\|msc\(file\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(n\(ame\(space\)\?\|osubgrouping\|ote\|\)\?\|overload\)\>/ contained
syntax match doxCommand /[\\@]\(p\(ackage\|age\|ar\(agraph\|am\(\[\(in\|in,out\|out\)\]\)\?\|block\)\?\|ost\|re\|rivate\(section\)\?\|roperty\|rotected\(section\)\?\|rotocol\|ublic\(section\)\?\|ure\)\?\)\>/ contained
syntax match doxCommand /[\\@]\(ref\(item\)\?\|relate[ds]\(also\)\?\|remarks\?\|result\|returns\?\|retval\|rtfonly\)\>/ contained
syntax match doxCommand /[\\@]\(sa\|secreflist\|section\|see\|short\|showinitializer\|since\|skip\(line\)\?\|snippet\(doc\|lineno\)\?\|startuml\|struct\|subpage\|subsection\|subsubsection\)\>/ contained
syntax match doxCommand /[\\@]\(tableofcontents\|test\|throws\?\|todo\|tparam\|typedef\)\>/ contained
syntax match doxCommand /[\\@]\(union\|until\|var\|verbatim\|verbinclude\|version\|vhdlflow\)\>/ contained
syntax match doxCommand /[\\@]\(warning\|weakgroup\|xmlonly\|xrefitem\)\>/ contained
syntax match doxCommand /[\\@][{}]/ contained
syntax match doxCommand /[\\@]\([$@\&~<>#%".|]\|::\|---\?\)/ contained
