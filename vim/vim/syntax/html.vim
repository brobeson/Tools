" Vim syntax file
" Language:		HTML
" Maintainer:	brobeson
" URL:			https://github.com/brobeson/Tools
" Last Change:	2014 December 31
"
" Much thanks to Claudio Fleiner. His html.vim file served as a good resource.

if !exists('html_version')
	let html_version = 5
endif

if exists('html_use_w3_style')
	syntax case match
else
	syntax case ignore
endif

syntax match htmlError /[<>&]/

" comments & server side directives {{{
" a source about html 4 comments: http://www.htmlhelp.com/reference/wilbur/misc/comment.html
syntax match  htmlServerSide      contained /<!#\(config\|echo\|elif\|else\|endif\|exec\|flastmod\|fsize\|include\|if\|printenv\|set\)/ms=s+2
syntax match  htmlServerSideError contained /\s\+#\(config\|echo\|elif\|else\|endif\|exec\|flastmod\|fsize\|include\|if\|printenv\|set\)/
if html_version == 4
	syntax region htmlComment    contained start=/--/   end=/--/
	syntax region htmlCommentTag           start=/<!/   end=/>/    contains=htmlComment,htmlServerSide
else
	syntax region htmlComment start=/<!--/ end=/-->/  contains=htmlServerSide
endif
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

syntax cluster htmlTagNames contains=htmlTagName,html4DepTagName,html5DepTagName,html5TagName
syntax region  htmlTag      start=/<[^\/!]/ end=/>/ fold contains=@htmlTagNames,@htmlAttributes,@htmlEvents
syntax region  htmlEndTag   start=/<\//     end=/>/      contains=@htmlTagNames
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
if exists('html_use_w3_style')
	syntax match htmlEvtHandler contained /=\(".*()"\|'.*()'\)/ms=s+1
else
	syntax match htmlEvtHandler contained /=\s*\(".*()"\|'.*()'\|[^'" \t>]\+()\)/ms=s+1
endif

syntax cluster htmlEvents contains=htmlEventName,html5DepEventName,html5EventName,htmlEvtHandler
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
syntax keyword html5DepAttrName contained align alink alt archive axis background bgcolor
syntax keyword html5DepAttrName contained border cellpadding cellspacing char charoff classid
syntax keyword html5DepAttrName contained code codebase codetype color compact declare face
syntax keyword html5DepAttrName contained frame frameborder hspace link longdesc marginheight
syntax keyword html5DepAttrName contained marginwidth nohref noresize noshade nowrap object
syntax keyword html5DepAttrName contained profile rev rules scheme scrolling standby summary
syntax keyword html5DepAttrName contained text valign valuetype vlink vspace
syntax match   html5DepAttrName contained /\<xml:space\>/

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
if exists('html_use_w3_style')
	syntax match htmlAttribValue contained /=\(".*"\|'.*'\)/ms=s+1
else
	syntax match htmlAttribValue contained /=\s*\(".*"\|'.*'\|[^'" \t>]\+\)/ms=s+1
endif

syntax cluster htmlAttributes contains=htmlAttrName,html5DepAttrName,html5AttrName,htmlAttribValue,htmlAttr
" }}}

" doctype {{{
syntax match   htmlDocTypeName  contained /!DOCTYPE/
syntax keyword html5DocTypeAttr contained html
syntax keyword html4DocTypeAttr contained public
syntax match   html4DtdStr      contained /\c\"-\/\/W3C\/\/DTD \(HTML 4\.01\|HTML 4\.01 Transitional\|HTML 4\.01 Frameset\|XHTML 1\.0 Strict\|XHTML 1\.0 Transitional\|XHTML 1\.0 Frameset\|XHTML 1\.1\)\/\/EN\"/
syntax match   html4DtdUrl      contained /\c\"http:\/\/www\.w3\.org\/TR\/\(html4\/strict\|html4\/loose\|html4\/frameset\|xhtml1\/DTD\/xhtml1-strict\|xhtml1\/DTD\/xhtml1-transitional\|xhtml1\/DTD\/xhtml1-frameset\|xhtml11\/DTD\/xhtml11\)\.dtd\"/
syntax region  htmlDocType                start=/\%^[\s\n]*<!/ end=/>/ contains=htmlDocTypeName,html5DocTypeAttr,html4DocTypeAttr,html4DtdStr,html4DtdUrl
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
syntax region  htmlCssTag            start=/<style/  keepend end=/<\/style>/ contains=@htmlCss,htmlTagName,htmlAttr,htmlAttribValue
syntax region  htmlCssAttr contained start=/style="/ keepend end=/"/         contains=@htmlCss,htmlAttrName
syntax cluster @htmlAttributes add=htmlCssAttr
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
highlight default link htmlUrlGrp           String

" highlighting for everything common between html 4 and 5
highlight default link htmlComment         Comment
highlight default link htmlCommentTag      Comment
highlight default link html4DepAttrName    Error
highlight default link htmlAttribValue     htmlAttribValueGrp
highlight default link htmlAttrName		   htmlAttributeNameGrp
highlight default link htmlDocTypeName	   Statement
highlight default link htmlEntity          htmlEntityGrp
highlight default link htmlError           Error
highlight default link htmlEventName	   htmlAttributeNameGrp
highlight default link htmlEvtHandler      Function
highlight default link htmlServerSide      PreProc
highlight default link htmlServerSideError Error
highlight default link htmlTagName		   Statement

" highlighting for html 5
if html_version == 5
	highlight default link html4DepTagName   htmlTagName
	highlight default link html4DocTypeAttr	 Error
	highlight default link html4DtdStr       Error
	highlight default link html4DtdUrl       Error
	highlight default link html5DepTagName   Error
	highlight default link html5DepAttrName  Error
	highlight default link html5DepEventName Error
	highlight default link html5DocTypeAttr  htmlAttrName
	highlight default link html5TagName	     htmlTagName
	highlight default link html5AttrName     htmlAttrName
	highlight default link html5EventName	 htmlAttributeNameGrp

" highlighting for html 4 (or anything else really)
else
	highlight default link html4DepTagName   Error
	highlight default link html4DocTypeAttr	 htmlAttrName
	highlight default link html4DtdStr       String
	highlight default link html4DtdUrl       htmlUrlGrp
	highlight default link html5DepTagName   htmlTagName
	highlight default link html5DepAttrName  htmlAttrName
	highlight default link html5DepEventName htmlAttrName
	highlight default link html5DocTypeAttr  Error
	highlight default link html5TagName      Error
	highlight default link html5AttrName     Error
	highlight default link html5EventName	 Error
endif
"}}}

" set the buffer's current syntax so that easily see what the syntax
" _should_ be.
if html_version == 5
	let b:current_syntax = 'html5'
else
	let b:current_syntax = 'html4'
endif

