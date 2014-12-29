" Vim syntax file
" Language:	HTML
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" URL:		http://www.fleiner.com/vim/syntax/html.vim
" Last Change:	2012 Oct 05

let syntax_file = "new"
"let syntax_file = "original"
"let html_wrong_comments = 1

if syntax_file == "original"
    " Please check :help html.vim for some comments and a description of the options

    " For version 5.x: Clear all syntax items
    " For version 6.x: Quit when a syntax file was already loaded
    if !exists("main_syntax")
	if version < 600
	    syntax clear
	elseif exists("b:current_syntax")
	    finish
	endif
	let main_syntax = 'html'
    endif

    let s:cpo_save = &cpo
    set cpo&vim

    " don't use standard HiLink, it will not work with included syntax files
    if version < 508
		command! -nargs=+ HtmlHiLink hi link <args>
    else
		command! -nargs=+ HtmlHiLink hi def link <args>
    endif

    syntax spell toplevel

    "syn case ignore

    " mark illegal characters
    "syn match htmlError "[<>&]"

    " tags
    "syn region  htmlString   contained start=+"+ end=+"+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc
    "syn region  htmlString   contained start=+'+ end=+'+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc
    "syn match   htmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1   contains=javaScriptExpression,@htmlPreproc
    "syn region  htmlEndTag             start=+</+      end=+>+ contains=htmlTagN,htmlTagError
    "syn region  htmlTag                start=+<[^/]+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster
    syn match   htmlTagN     contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
    syn match   htmlTagN     contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
    syn match   htmlTagError contained "[^>]<"ms=s+1

    " tag names
    "syn keyword htmlTagName contained address applet area a base basefont
    "syn keyword htmlTagName contained big blockquote br caption center
    "syn keyword htmlTagName contained cite code dd dfn dir div dl dt font
    "syn keyword htmlTagName contained form hr html img
    "syn keyword htmlTagName contained input isindex kbd li link map menu
    "syn keyword htmlTagName contained meta ol option param pre p samp span
    "syn keyword htmlTagName contained select small strike sub sup
    "syn keyword htmlTagName contained table td textarea th tr tt ul var xmp
    "syn match htmlTagName contained "\<\(b\|i\|u\|h[1-6]\|em\|strong\|head\|body\|title\)\>"

    " new html 4.0 tags
    "syn keyword htmlTagName contained abbr acronym bdo button col label
    "syn keyword htmlTagName contained colgroup del fieldset iframe ins legend
    "syn keyword htmlTagName contained object optgroup q s tbody tfoot thead

    " legal arg names
    "syn keyword htmlArg contained action
    "syn keyword htmlArg contained align alink alt archive background bgcolor
    "syn keyword htmlArg contained border bordercolor cellpadding
    "syn keyword htmlArg contained cellspacing checked class clear code codebase color
    "syn keyword htmlArg contained cols colspan content coords enctype face
    "syn keyword htmlArg contained gutter height hspace id
    "syn keyword htmlArg contained link lowsrc marginheight
    "syn keyword htmlArg contained marginwidth maxlength method name prompt
    "syn keyword htmlArg contained rel rev rows rowspan scrolling selected shape
    "syn keyword htmlArg contained size src start target text type url
    "syn keyword htmlArg contained usemap ismap valign value vlink vspace width wrap
    "syn match   htmlArg contained "\<\(http-equiv\|href\|title\)="me=e-1

    " Netscape extensions
    "syn keyword htmlTagName contained frame noframes frameset nobr blink
    "syn keyword htmlTagName contained layer ilayer nolayer spacer
    "syn keyword htmlArg     contained frameborder noresize pagex pagey above below
    "syn keyword htmlArg     contained left top visibility clip id noshade
    "syn match   htmlArg     contained "\<z-index\>"

    " Microsoft extensions
    "syn keyword htmlTagName contained marquee

    " html 4.0 arg names
    "syn match   htmlArg contained "\<\(accept-charset\|label\)\>"
    "syn keyword htmlArg contained abbr accept accesskey axis char charoff charset
    "syn keyword htmlArg contained cite classid codetype compact data datetime
    "syn keyword htmlArg contained declare defer dir disabled for frame
    "syn keyword htmlArg contained headers hreflang lang language longdesc
    "syn keyword htmlArg contained multiple nohref nowrap object profile readonly
    "syn keyword htmlArg contained rules scheme scope span standby style
    "syn keyword htmlArg contained summary tabindex valuetype version

    " special characters
    "syn match htmlSpecialChar "&#\=[0-9A-Za-z]\{1,8};"

    " Comments (the real ones or the old netscape ones)
    "if exists("html_wrong_comments")
	"	syn region htmlComment                start=+<!--+    end=+--\s*>+ contains=@Spell
    "else
	"	syn region htmlComment                start=+<!+      end=+>+   contains=htmlCommentPart,htmlCommentError,@Spell
	"	syn match  htmlCommentError contained "[^><!]"
	"	syn region htmlCommentPart  contained start=+--+      end=+--\s*+  contains=@htmlPreProc,@Spell
    "endif
    "syn region htmlComment                  start=+<!DOCTYPE+ keepend end=+>+

    " server-parsed commands
    "syn region htmlPreProc start=+<!--#+ end=+-->+ contains=htmlPreStmt,htmlPreError,htmlPreAttr
    "syn match htmlPreStmt contained "<!--#\(config\|echo\|exec\|fsize\|flastmod\|include\|printenv\|set\|if\|elif\|else\|endif\|geoguide\)\>"
	"syn match htmlPreError contained "<!--#\S*"ms=s+4
	"syn match htmlPreAttr contained "\w\+=[^"]\S\+" contains=htmlPreProcAttrError,htmlPreProcAttrName
	"syn region htmlPreAttr contained start=+\w\+="+ skip=+\\\\\|\\"+ end=+"+ contains=htmlPreProcAttrName keepend
	"syn match htmlPreProcAttrError contained "\w\+="he=e-1
	"syn match htmlPreProcAttrName contained "\(expr\|errmsg\|sizefmt\|timefmt\|var\|cgi\|cmd\|file\|virtual\|value\)="he=e-1

	"if !exists("html_no_rendering")
	"    " rendering
	"    syn cluster htmlTop contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLink,javaScript,@htmlPreproc

	"    syn region htmlBold start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
	"    syn region htmlBold start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
	"    syn region htmlBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic
	"    syn region htmlBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlBoldItalicUnderline
	"    syn region htmlBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmlBoldItalicUnderline
	"    syn region htmlBoldUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop
	"    syn region htmlBoldUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop
	"    syn region htmlBoldItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic

	"    syn region htmlUnderline start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlUnderlineBold,htmlUnderlineItalic
	"    syn region htmlUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlUnderlineBoldItalic
	"    syn region htmlUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlUnderlineBoldItalic
	"    syn region htmlUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlUnderlineItalicBold
	"    syn region htmlUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmlUnderlineItalicBold
	"    syn region htmlUnderlineItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop
	"    syn region htmlUnderlineItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop
	"    syn region htmlUnderlineBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop
	"    syn region htmlUnderlineBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop

	"    syn region htmlItalic start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlItalicBold,htmlItalicUnderline
	"    syn region htmlItalic start="<em\>" end="</em>"me=e-5 contains=@htmlTop
	"    syn region htmlItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlItalicBoldUnderline
	"    syn region htmlItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlItalicBoldUnderline
	"    syn region htmlItalicBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop
	"    syn region htmlItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlItalicUnderlineBold
	"    syn region htmlItalicUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop
	"    syn region htmlItalicUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop

	"    syn match htmlLeadingSpace "^\s\+" contained
	"    syn region htmlLink start="<a\>\_[^>]*\<href\>" end="</a>"me=e-4 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLeadingSpace,javaScript,@htmlPreproc
	"    syn region htmlH1 start="<h1\>" end="</h1>"me=e-5 contains=@htmlTop
	"    syn region htmlH2 start="<h2\>" end="</h2>"me=e-5 contains=@htmlTop
	"    syn region htmlH3 start="<h3\>" end="</h3>"me=e-5 contains=@htmlTop
	"    syn region htmlH4 start="<h4\>" end="</h4>"me=e-5 contains=@htmlTop
	"    syn region htmlH5 start="<h5\>" end="</h5>"me=e-5 contains=@htmlTop
	"    syn region htmlH6 start="<h6\>" end="</h6>"me=e-5 contains=@htmlTop
	"    syn region htmlHead start="<head\>" end="</head>"me=e-7 end="<body\>"me=e-5 end="<h[1-6]\>"me=e-3 contains=htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLink,htmlTitle,javaScript,cssStyle,@htmlPreproc
	"    syn region htmlTitle start="<title\>" end="</title>"me=e-8 contains=htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc
	"endif

	"syn keyword htmlTagName         contained noscript
	"syn keyword htmlSpecialTagName  contained script style
	if main_syntax != 'java' || exists("java_javascript")
	    " JAVA SCRIPT
	    syn include @htmlJavaScript syntax/javascript.vim
	    unlet b:current_syntax
	    syn region  javaScript start=+<script\_[^>]*>+ keepend end=+</script>+me=s-1 contains=@htmlJavaScript,htmlCssStyleComment,htmlScriptTag,@htmlPreproc
	    syn region  htmlScriptTag     contained start=+<script+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent
	    HtmlHiLink htmlScriptTag htmlTag

	    " html events (i.e. arguments that include javascript commands)
	    "if exists("html_extended_events")
		"	syn region htmlEvent        contained start=+\<on\a\+\s*=[\t ]*'+ end=+'+ contains=htmlEventSQ
		"	syn region htmlEvent        contained start=+\<on\a\+\s*=[\t ]*"+ end=+"+ contains=htmlEventDQ
	    "else
		"	syn region htmlEvent        contained start=+\<on\a\+\s*=[\t ]*'+ end=+'+ keepend contains=htmlEventSQ
		"	syn region htmlEvent        contained start=+\<on\a\+\s*=[\t ]*"+ end=+"+ keepend contains=htmlEventDQ
	    "endif
	    "syn region htmlEventSQ        contained start=+'+ms=s+1 end=+'+me=s-1 contains=@htmlJavaScript
	    "syn region htmlEventDQ        contained start=+"+ms=s+1 end=+"+me=s-1 contains=@htmlJavaScript
	    "HtmlHiLink htmlEventSQ htmlEvent
	    "HtmlHiLink htmlEventDQ htmlEvent

	    " a javascript expression is used as an arg value
	    syn region  javaScriptExpression contained start=+&{+ keepend end=+};+ contains=@htmlJavaScript,@htmlPreproc
	endif

	if main_syntax != 'java' || exists("java_vb")
	    " VB SCRIPT
	    syn include @htmlVbScript syntax/vb.vim
	    unlet b:current_syntax
	    syn region  javaScript start=+<script \_[^>]*language *=\_[^>]*vbscript\_[^>]*>+ keepend end=+</script>+me=s-1 contains=@htmlVbScript,htmlCssStyleComment,htmlScriptTag,@htmlPreproc
	endif

	syn cluster htmlJavaScript      add=@htmlPreproc

	"if main_syntax != 'java' || exists("java_css")
	"    " embedded style sheets
	"    syn keyword htmlArg           contained media
	"    syn include @htmlCss syntax/css.vim
	"    unlet b:current_syntax
	"    syn region cssStyle start=+<style+ keepend end=+</style>+ contains=@htmlCss,htmlTag,htmlEndTag,htmlCssStyleComment,@htmlPreproc
	"    syn match htmlCssStyleComment contained "\(<!--\|-->\)"
	"    syn region htmlCssDefinition matchgroup=htmlArg start='style="' keepend matchgroup=htmlString end='"' contains=css.*Attr,css.*Prop,cssComment,cssLength,cssColor,cssURL,cssImportant,cssError,cssString,@htmlPreproc
	"    HtmlHiLink htmlStyleArg htmlString
	"endif

	if main_syntax == "html"
	    " synchronizing (does not always work if a comment includes legal
	    " html tags, but doing it right would mean to always start
	    " at the first line, which is too slow)
	    syn sync match htmlHighlight groupthere NONE "<[/a-zA-Z]"
	    syn sync match htmlHighlight groupthere javaScript "<script"
	    syn sync match htmlHighlightSkip "^.*['\"].*$"
	    syn sync minlines=10
	endif

	" The default highlighting.
	"if version >= 508 || !exists("did_html_syn_inits")
	"    if version < 508
	"		let did_html_syn_inits = 1
	"    endif
	    "HtmlHiLink htmlTag                     Function
	    "HtmlHiLink htmlEndTag                  Identifier
	    "HtmlHiLink htmlArg                     Type
	    "HtmlHiLink htmlTagName                 Statement
	    "HtmlHiLink htmlSpecialTagName          Exception
	    "HtmlHiLink htmlSpecialChar             Special

	    "if !exists("html_no_rendering")
			"HtmlHiLink htmlH1                      Title
			"HtmlHiLink htmlH2                      htmlH1
			"HtmlHiLink htmlH3                      htmlH2
			"HtmlHiLink htmlH4                      htmlH3
			"HtmlHiLink htmlH5                      htmlH4
			"HtmlHiLink htmlH6                      htmlH5
			"HtmlHiLink htmlHead                    PreProc
			"HtmlHiLink htmlTitle                   Title
			"HtmlHiLink htmlBoldItalicUnderline     htmlBoldUnderlineItalic
			"HtmlHiLink htmlUnderlineBold           htmlBoldUnderline
			"HtmlHiLink htmlUnderlineItalicBold     htmlBoldUnderlineItalic
			"HtmlHiLink htmlUnderlineBoldItalic     htmlBoldUnderlineItalic
			"HtmlHiLink htmlItalicUnderline         htmlUnderlineItalic
			"HtmlHiLink htmlItalicBold              htmlBoldItalic
			"HtmlHiLink htmlItalicBoldUnderline     htmlBoldUnderlineItalic
			"HtmlHiLink htmlItalicUnderlineBold     htmlBoldUnderlineItalic
			"HtmlHiLink htmlLink                    Underlined
			"HtmlHiLink htmlLeadingSpace            None
			"if !exists("html_my_rendering")
			"	hi def htmlBold                term=bold cterm=bold gui=bold
			"	hi def htmlBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
			"	hi def htmlBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
			"	hi def htmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
			"	hi def htmlUnderline           term=underline cterm=underline gui=underline
			"	hi def htmlUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
			"	hi def htmlItalic              term=italic cterm=italic gui=italic
			"endif
	    "endif

	    "HtmlHiLink htmlPreStmt            PreProc
	    "HtmlHiLink htmlPreError           Error
	    "HtmlHiLink htmlPreProc            PreProc
	    "HtmlHiLink htmlPreAttr            String
	    "HtmlHiLink htmlPreProcAttrName    PreProc
	    "HtmlHiLink htmlPreProcAttrError   Error
	    "HtmlHiLink htmlSpecial            Special
	    "HtmlHiLink htmlString             String
	    "HtmlHiLink htmlComment            Comment
	    "HtmlHiLink htmlCommentPart        Comment
	    "HtmlHiLink htmlValue              String
	    "HtmlHiLink htmlCommentError       htmlError
	    HtmlHiLink htmlTagError           htmlError
	    "HtmlHiLink htmlEvent              javaScript
	    "HtmlHiLink htmlError              Error

	    HtmlHiLink javaScript             Special
	    HtmlHiLink javaScriptExpression   javaScript
	    "HtmlHiLink htmlCssStyleComment    Comment
	    "HtmlHiLink htmlCssDefinition      Special
	"endif

"	delcommand HtmlHiLink
"
"	let b:current_syntax = "html"
"
"	if main_syntax == 'html'
"	    unlet main_syntax
"	endif
"
"	let &cpo = s:cpo_save
"	unlet s:cpo_save
	" vim: ts=8

else
    " TODO list {{{
    " 1)    highlight the / in the closing tag
    " 2)    enforce XHTML syntax
	"		b) mandatory doctype
	"		c) mandatory html, head, title, and body tags
	"		d) mandatory xmlns attribute in html tag
	"		e) proper tag nesting
	"		f) closed tags
	"		g) one root element
	"		h) attribute values must be quoted
	"		i) attribute minimization is not allowed
	" 6)	highlight illegal characters
	" 7)	highlight character codes, eg: &nbsp
	" 8)	test the tags removed in html 4 and reintroduced in html 5
	" 9)	for html 4, highlight as an error the doctype strings which are
	"		incorrect.
	" 10)	for html 4, highlight as an error incorrect dtd string and dtd url
	"		combinations
	" }}}

    if !exists("html_version")
		let html_version = 5
    endif
	if !exists("html_use_xhtml")
		let html_use_xhtml = 0
	endif

	" xhtml requires that tag and attribute names be in lower case. html 5
	" does not
	if html_use_xhtml == 0
		syntax case ignore
	else
		syntax case match
	endif

    syntax match htmlError /[<>&]/

	" comments & server side directives {{{
	" a source about html 4 comments: http://www.htmlhelp.com/reference/wilbur/misc/comment.html
	syntax region html4Comment    contained start=/--/   end=/--/
	syntax region html4CommentTag           start=/<!/   end=/>/    contains=html4Comment,htmlServerSide
	syntax region html5Comment              start=/<!--/ end=/-->/  contains=htmlServerSide
	syntax match  htmlServerSide  contained "#\(config\|echo\|elif\|else\|endif\|exec\|flastmod\|fsize\|include\|if\|printenv\|set\)"
	" }}}

	" tags {{{
    " tag names
    syntax keyword htmlTagName contained a abbr address area b base bdo blockquote body br button
    syntax keyword htmlTagName contained caption cite code col colgroup dd del dfn div dl dt em
    syntax keyword htmlTagName contained fieldset form h1 h2 h3 h4 h5 h6 head hr html i iframe img
    syntax keyword htmlTagName contained input ins kbd label legend li link map meta noscript
    syntax keyword htmlTagName contained object ol optgroup option p param pre q samp script
    syntax keyword htmlTagName contained select small span strong style sub sup table tbody td
    syntax keyword htmlTagName contained textarea tfoot th thead title tr ul var

    " tag names removed in HTML 4
    syntax keyword html4DepTagName contained menu s u

    " tag names removed in HTML 5
    syntax keyword html5DepTagName contained acronym applet basefont big center dir font frame
    syntax keyword html5DepTagName contained frameset noframes strike tt

    " tag names introduced in HTML 5
    syntax keyword html5TagName contained article aside audio bdi canvas datalist details dialog
    syntax keyword html5TagName contained embed figcaption figure footer header hgroup keygen
    syntax keyword html5TagName contained main mark menu menuitem meter nav output progress rp rt
    syntax keyword html5TagName contained ruby s section source summary time track u video wbr

    syntax region htmlTag	  start=/<[^\/!]/ end=/>/ fold contains=htmlTagName,html4DepTagName,html5TagName,html5DepTagName,htmlAttr,html5AttribValue,htmlEventName,html5DebEventName,html5EventName,html5EvtHandler,htmlCssAttr
    syntax region htmlEndTag  start=/<\//     end=/>/      contains=htmlTagName,html5TagName,html5DepTagName
	" }}}

	" events {{{
	syntax keyword htmlEventName contained onabort onblur onchange onclick oncopy oncut ondblclick
	syntax keyword htmlEventName contained onfocus onkeydown onkeypress onkeyup onload onmousedown
	syntax keyword htmlEventName contained onmousemove onmouseout onmouseover onmouseup onpaste
	syntax keyword htmlEventName contained onsearch onselect onsubmit onunload

	" deprecated in HTML 5
	syntax keyword html5DepEventName contained onmousewheel

	" introduced in HTML 5
	syntax keyword html5EventName contained onafterprint onbeforeprint onbeforeunload oncanplay 
	syntax keyword html5EventName contained oncanplaythrough oncontextmenu oncuechange ondrag 
	syntax keyword html5EventName contained ondragend ondragenter ondragleave ondragover ondragstart 
	syntax keyword html5EventName contained ondrop ondurationchange onemptied onended onerror 
	syntax keyword html5EventName contained onhashchange oninput oninvalid onloadeddata onloadedmetadata 
	syntax keyword html5EventName contained onloadstart onmessage onoffline ononline onpagehide 
	syntax keyword html5EventName contained onpageshow onpause onplay onplaying onpopstate onprogress 
	syntax keyword html5EventName contained onratechange onreset onresize onscroll onseeked onseeking 
	syntax keyword html5EventName contained onshow onstalled onstorage onsuspend ontimeupdate 
	syntax keyword html5EventName contained ontoggle onvolumechange onwaiting onwheel

	" event handlers
	syntax match html5EvtHandler contained /=\s*\(".*()"\|'.*()'\|[^'" \t>]\+()\)/ms=s+1
	" }}}

	" attributes {{{
    " attribute names
    syntax keyword htmlAttrName contained abbr accept accesskey action alt charset
	syntax keyword htmlAttrName contained checked cite class cols colspan content coords data
	syntax keyword htmlAttrName contained datetime defer dir disabled enctype headers height href
	syntax keyword htmlAttrName contained hreflang id ismap label lang maxlength media
	syntax keyword htmlAttrName contained method name readonly rel rows rowspan scope selected
	syntax keyword htmlAttrName contained shape size sortable sorted span src start style tabindex
	syntax keyword htmlAttrName contained target title type usemap value width xmlns
	syntax match   htmlAttrName contained /\<\(accept-charset\|http-equiv\)\>/

    " attributes deprecated in HTML 5
	syntax keyword html4DepAttrName contained align alink alt archive axis background bgcolor
	syntax keyword html4DepAttrName contained border cellpadding cellspacing char charoff classid
	syntax keyword html4DepAttrName contained code codebase codetype color compact declare face
	syntax keyword html4DepAttrName contained frame frameborder hspace link longdesc marginheight
	syntax keyword html4DepAttrName contained marginwidth nohref noresize noshade nowrap object
	syntax keyword html4DepAttrName contained profile rev rules scheme scrolling standby summary
	syntax keyword html4DepAttrName contained text valign valuetype vlink vspace
	syntax match   html4DepAttrName contained /\<xml:space\>/

    " attribute names introduced in HTML 5
	syntax keyword html5AttrName contained async autocomplete autofocus autoplay autosize challenge
	syntax keyword html5AttrName contained command contenteditable contextmenu controls crossorigin
	syntax keyword html5AttrName contained default download draggable dropzone for form formaction
	syntax keyword html5AttrName contained formenctype formmethod formnovalidate formtarget hidden
	syntax keyword html5AttrName contained high icon keytype kind list loop low manifest max min
	syntax keyword html5AttrName contained multiple muted novalidate open optimum pattern
	syntax keyword html5AttrName contained placeholder poster preload radiogroup required reversed
	syntax keyword html5AttrName contained sandbox scoped seamless sizes spellcheck srcdoc srclang
	syntax keyword html5AttrName contained step translate wrap
    syntax match   html5AttrName contained /data-[a-z\-]\+/

	" this syntax match prevents conflict with other keywords of the
	" same name. for example, 'title' is both a tag and an attribute name.
	syntax match htmlAttr contained /\<.\+\>=/me=e-1 contains=htmlAttrName,html5DepAttrName,html5AttrName

	" attribute values
	syntax match html5AttribValue contained /=\s*\(".*"\|'.*'\|[^'" \t>]\+\)/ms=s+1
	" }}}

    " doctype {{{
	syntax match   htmlDocTypeName  contained /!DOCTYPE/
	syntax keyword htmlDocTypeAttr  contained html
	syntax keyword html4DocTypeAttr contained public
	syntax match   html4DtdStr      contained /\c\"-\/\/W3C\/\/DTD \(HTML 4\.01\|HTML 4\.01 Transitional\|HTML 4\.01 Frameset\|XHTML 1\.0 Strict\|XHTML 1\.0 Transitional\|XHTML 1\.0 Frameset\|XHTML 1\.1\)\/\/EN\"/
	syntax match   html4DtdUrl      contained /\c\"http:\/\/www\.w3\.org\/TR\/\(html4\/strict\|html4\/loose\|html4\/frameset\|xhtml1\/DTD\/xhtml1-strict\|xhtml1\/DTD\/xhtml1-transitional\|xhtml1\/DTD\/xhtml1-frameset\|xhtml11\/DTD\/xhtml11\)\.dtd\"/
	syntax region  htmlDocType                start=/\%^[\s\n]*<!/ end=/>/ contains=htmlDocTypeName,htmlDocTypeAttr,html4DocTypeAttr,html4DtdStr,html4DtdUrl
	" }}}

	" entities and diactrical marks {{{
	" entity numbers. note that the 'x' near the front is allowed for any
	" number since the set of decimal digits is a subset of hex digits. this
	" should also match diacritical marks
	syntax match htmlEntity /&#x\?[[:digit:][:xdigit:]]\{1,4};/

	" a note about entity names. i'm not aware of a way to set keywords, and
	" have a containing match only highlight when the keyword is contained.
	" hence, just matches with all the possible entity names.

	" math entity names from http://www.w3schools.com/charsets/ref_utf_math.asp
	syntax match htmlEntity /&\(and\|ang\|asymp\|cap\|cong\|cup\|empty\|equiv\|exist\);/
	syntax match htmlEntity /&\(forall\|ge\|infin\|int\|isin\|le\|lowast\|minus\|nabla\);/
	syntax match htmlEntity /&\(ne\|ni\|notin\|nsub\|oplus\|or\|otimes\|part\|perp\);/
	syntax match htmlEntity /&\(prod\|prop\|radic\|sdot\|sim\|sub\|sube\|sum\|sup\);/
	syntax match htmlEntity /&\(supe\|there\);/

	" greek letter entity names from http://www.w3schools.com/charsets/ref_utf_greek.asp
	syntax match htmlEntity /&\([Aa]lpha\|[Bb]eta\|[Gg]amma\|[Dd]elta\|[Ee]psilon\);/
	syntax match htmlEntity /&\([Zz]eta\|[Ee]ta\|[Tt]heta\|[Ii]ota\|[Kk]appa\|[Ll]ambda\);/
	syntax match htmlEntity /&\([Mm]u\|[Nn]u\|[Xx]i\|[Oo]micron\|[Pp]i\|[Rr]ho\|[Ss]igma\);/
	syntax match htmlEntity /&\([Tt]au\|[Uu]psilon\|[Pp]hi\|[Cc]hi\|[Pp]si\|[Oo]mega\);/
	syntax match htmlEntity /&\(thetasym\|upsih\|straightphi\|piv\|[Gg]ammad\|varkappa\);/
	syntax match htmlEntity /&\(varrho\|straightepsilon\|backepsilon\);/

	" miscellaneous entitys from:
	" http://www.w3schools.com/html/html_entities.asp
	" http://www.w3schools.com/html/html_symbols.asp
	" http://www.w3schools.com/charsets/ref_utf_currency.asp
	" http://www.w3schools.com/charsets/ref_utf_arrows.asp
	" http://www.w3schools.com/charsets/ref_utf_symbols.asp
	syntax match htmlEntity /&\(amp\|cent\|clubs\|copy\|crarr\|d[Aa]rr\|diams\|euro\);/
	syntax match htmlEntity /&\(gt\|h[Aa]rr\|hearts\|l[Aa]rr\|lt\|nbsp\|pound\|r[Aa]rr\);/
	syntax match htmlEntity /&\(reg\|spades\|trade\|u[Aa]rr\|yen\);/
	" }}}

	" embedded CSS {{{
	syntax include @htmlCss syntax/css.vim
	syntax region htmlCssTag  start=/<style/  keepend end=/<\/style>/ contains=@htmlCss,htmlTagName,htmlAttr,html5AttribValue
	syntax region htmlCssAttr contained start=/style="/ keepend end=/"/         contains=@htmlCss,htmlAttrName
	" }}}

    " The default highlighting. {{{
	" I have a few custom groups, based on Visual Studio 2013's dark color
	" scheme. These line link those custom groups to built in groups. That
	" will allow highlighting for those who don't care to add the custom
	" groups to their colorscheme file. My testing indicated that these links
	" won't interfere with the custom highlight commands in the colorscheme
	" file.
	highlight default link htmlAttributeNameGrp Keyword
	highlight default link htmlAttribValueGrp   Keyword
	highlight default link htmlEntityGrp        Constant
	highlight default link urlGrp               String

	" highlighting for everything common between html 4 and 5
	highlight default link html5Comment     Comment
    highlight default link htmlDocTypeName	Statement
    highlight default link htmlTagName		Statement
    highlight default link htmlAttrName		htmlAttributeNameGrp
    highlight default link htmlEventName	htmlAttributeNameGrp
	"highlight defautl link htmlAttr
	highlight default link html4DepTagName  Error
	highlight default link html4DepAttrName Error
	highlight default link htmlDocTypeAttr  htmlAttrName
	highlight default link htmlEntity       htmlEntityGrp
	highlight default link htmlError        Error
	highlight default link htmlServerSide   PreProc

	" highlighting for html 5
    if html_version == 5
		highlight default link html4DocTypeAttr	 Error
		highlight default link html4DtdStr       Error
		highlight default link html4DtdUrl       Error
		highlight default link html5DepTagName   Error
		highlight default link html5DepAttrName  Error
		highlight default link html5DepEventName Error
		highlight default link html5TagName	     htmlTagName
		highlight default link html5AttrName     htmlAttrName
		highlight default link html5AttribValue  Function
		highlight default link html5EvtHandler   Function
		highlight default link html5EventName	 htmlAttributeNameGrp
	
	" highlighting for html 4 (or anything else really)
    else
		highlight default link html4DocTypeAttr	 htmlAttrName
		highlight default link html4DtdStr       String
		highlight default link html4DtdUrl       urlGrp
		highlight default link html5DepTagName   htmlTagName
		highlight default link html5DepAttrName  htmlAttrName
		highlight default link html5DepEventName htmlAttrName
		highlight default link html5TagName      Error
		highlight default link html5AttrName     Error
		highlight default link html5AttribValue  Error
		highlight default link html5EvtHandler   Error
		highlight default link html5EventName	 Error
    endif
	"}}}

	" set the buffer's current syntax so that easily see what the syntax
	" _should_ be.
	if html_version == 5
		let b:current_syntax = "html5"
	else
		let b:current_syntax = "html4"
	endif
endif

