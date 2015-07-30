" Vim syntax file
" Language:		OpenGL Shader Language (GLSL) - Tessellation Evaluation Shaders
" Maintainer:	Brendan Robeson (ogslanger@vt.edu)
" Last Change:	2014 June 3

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

" Read the glsl base syntax to start with
if version < 600
	so <sfile>:p:h/glslBase.vim
else
	runtime! syntax/glslBase.vim
	unlet b:current_syntax
endif

" override the 'not allowed' items from the base syntax
syntax keyword glslBuiltIn	gl_PerVertex       gl_Position       gl_PointSize      gl_ClipDistance
syntax keyword glslBuiltIn	gl_PatchVerticesIn gl_PrimitiveID    gl_TessCoord      gl_in
syntax keyword glslBuiltIn	gl_out             gl_TessLevelOuter gl_TessLevelInner

hi def link glslBuiltIn		Keyword

let b:current_syntax = 'glslVertex'

