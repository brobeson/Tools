" Vim syntax file
" Language:		OpenGL Shader Language (GLSL) - Fragment Shaders
" Maintainer:	Brendan Robeson (ogslanger@vt.edu)
" Last Change:	2014 June 3

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Read the glsl base syntax to start with
if version < 600
	so <sfile>:p:h/glslBase.vim
else
	runtime! syntax/glslBase.vim
	unlet b:current_syntax
endif

" override the "not allowed" items from the base syntax
syntax keyword glslBuiltIn	gl_FragCoord     gl_FrontFacing   gl_ClipDistance   gl_PointCoord
syntax keyword glslBuiltIn	gl_PrimitiveID   gl_SampleID      gl_SamplePosition gl_SampleMaskIn
syntax keyword glslBuiltIn	gl_Layer         gl_ViewportIndex gl_FragDepth      gl_SampleMask
syntax keyword glslFunction	noise1
syntax keyword glslFunction	EmitStreamVertex EndStreamPrimitive    EmitVertex         EndPrimitive
syntax keyword glslFunction	textureSize      textureQueryLod       textureQueryLevels texture textureProj  textureLod           textureOffset texelFetch
syntax keyword glslFunction	texelFetchOffset textureProjOffset     textureLodOffset   textureProjLod       textureProjLodOffset textureGrad   textureGradOffset
syntax keyword glslFunction	textureProjGrad  textureProjGradOffset textureGather      textureGatherOffset  textureGatherOffsets
syntax keyword glslFunction	dFdx dFdy fwidth interpolateAtCentroid interpolateAtSample interpolateAtOffset

hi def link glslBuiltIn		Keyword

let b:current_syntax = "glslVertex"

