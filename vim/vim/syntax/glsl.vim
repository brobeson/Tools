" Vim syntax file
" Language:		OpenGL Shader Language (GLSL) 4.5
" Maintainer:	Brendan Robeson (https://github.com/brobeson/Tools)
" Last Change:	2015 August 3

" Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
    finish
endif


" GLSL numbers {{{
" ignore case for the type suffixes: f and F are both ok.
syntax case ignore

"integer number, or floating point number without a dot and with 'f'.
syntax match	glslNumbers		display transparent '\<\d\|\.\d' contains=glslNumber,glslFloat,glslOctalError,glslOctal

" Same, but without octal error (for comments)
syntax match	glslNumber		display contained '\d\+u\?\>'

"hex number
syntax match	glslHexZero		display contained '0x'
syntax match	glslNumber		display contained '0x\x\+u\?\>' contains=glslHexZero

" Flag the first zero of an octal number as something special
syntax match	glslOctal		display contained '0\o\+u\?\>' contains=glslOctalZero
syntax match	glslOctalZero	display contained '\<0'
syntax match	glslFloat		display contained '\d\+l\?f'

"floating point number, with dot, optional exponent
syntax match	glslFloat		display contained '\d\+\.\d*\(e[-+]\?\d\+\)\?\(f\|lf\)\?'

"floating point number, starting with a dot, optional exponent
syntax match	glslFloat		display contained '\.\d\+\(e[-+]\?\d\+\)\?\(f\|lf\)\?\>'

"floating point number, without dot, with exponent
syntax match	glslFloat		display contained '\d\+e[-+]\?\d\+\(f\|lf\)\?\>'

" flag an octal number with wrong digits
syntax match	glslOctalError	display contained '0\o*[89]\d*'

" restore case sensitivity
syntax case match
"}}}

" GLSL comments {{{
syntax keyword	glslTodo			TODO FIXME XXX HACK BUG			contained
syntax region	glslComment			start='//'  skip='\\$' end='$'	keepend contains=glslTodo
syntax region	glslComment			start='/\*'            end='\*/'
"}}}

" GLSL built in constants {{{
syntax keyword glslBoolean	true false
syntax keyword glslConstant	gl_MaxAtomicCounterBindings
						\	gl_MaxAtomicCounterBufferSize
						\	gl_MaxClipDistances
						\	gl_MaxCombinedAtomicCounterBuffers
						\	gl_MaxCombinedAtomicCounters
						\	gl_MaxCombinedClipAndCullDistances
						\	gl_MaxCombinedImageUnitsAndFragmentOutputs
						\	gl_MaxCombinedImageUniforms
						\	gl_MaxCombinedShaderOutputResources
						\	gl_MaxCombinedTextureImageUnits
						\	gl_MaxComputeAtomicGounterBuffers
						\	gl_MaxComputeAtomicCounters
						\	gl_MaxComputeImageUniforms
						\	gl_MaxComputeTextureImageUnits
						\	gl_MaxComputeUniformComponents
						\	gl_MaxComputeWorkGroupCount
						\	gl_MaxComputeWorkGroupSize
						\	gl_MaxCullDistances
						\	gl_MaxProgramTexelOffset
						\	gl_MaxDrawBuffers
						\	gl_MaxFragmentAtomicCounterBuffers
						\	gl_MaxFragmentAtomicCounters
						\	gl_MaxFragmentImageUniforms
						\	gl_MaxFragmentInputComponents
						\	gl_MaxFragmentUniformComponents
						\	gl_MaxFragmentUniformVectors
						\	gl_MaxGeometryAtomicCounterBuffers
						\	gl_MaxGeometryAtomicCounters
						\	gl_MaxGeometryImageUniforms
						\	gl_MaxGeometryInputComponents
						\	gl_MaxGeometryOutputComponents
						\	gl_MaxGeometryOutputVertices
						\	gl_MaxGeometryTextureImageUnits
						\	gl_MaxGeometryTotalOutputComponents
						\	gl_MaxGeometryUniformComponents
						\	gl_MaxGeometryVaryingComponents
						\	gl_MaxImageSamples
						\	gl_MaxImageUnits
						\	gl_MaxPatchVertices
						\	gl_MaxSamples
						\	gl_MaxTessControlAtomicCounterBuffers
						\	gl_MaxTessControlAtomicCounters
						\	gl_MaxTessControlImageUniforms
						\	gl_MaxTessControlInputComponents
						\	gl_MaxTessControlOutputComponents
						\	gl_MaxTessControlTextureImageUnits
						\	gl_MaxTessControlTotalOutputComponents
						\	gl_MaxTessControlUniformComponents
						\	gl_MaxTessEvaluationAtomicCounterBuffers
						\	gl_MaxTessEvaluationAtomicCounters
						\	gl_MaxTessEvaluationImageUniforms
						\	gl_MaxTessEvaluationInputComponents
						\	gl_MaxTessEvaluationOutputComponents
						\	gl_MaxTessEvaluationTextureImageUnits
						\	gl_MaxTessEvaluationUniformComponents
						\	gl_MaxTessGenLevel
						\	gl_MaxTessPatchComponents
						\	gl_MaxTextureImageUnits
						\	gl_MaxTransformFeedbackBuffers
						\	gl_MaxTransformFeedbackInterleavedComponents
						\	gl_MaxVaryingComponents
						\	gl_MaxVaryingVectors
						\	gl_MaxVertexAtomicCounterBuffers
						\	gl_MaxVertexAtomicCounters
						\	gl_MaxVertexAttribs
						\	gl_MaxVertexImageUniforms
						\	gl_MaxVertexOutputComponents
						\	gl_MaxVertexTextureImageUnits
						\	gl_MaxVertexUniformComponents
						\	gl_MaxVertexUniformVectors
						\	gl_MaxViewports
						\	gl_MinProgramTexelOffset
"}}}

" GLSL built in functions {{{
syntax keyword glslFunction	abs
						\	acos
						\	acosh
						\	any
						\	asin
						\	asinh
						\	atan
						\	atanh
						\	atomicCounter
						\	atomicCounterDecrement
						\	atomicCounterIncrement
						\	atomicAdd
						\	atomicAnd
						\	atomicCompSwap
						\	atomicExchange
						\	atomicMax
						\	atomicMin
						\	atomicOr
						\	atomicXor
						\	barrier
						\	bitCount
						\	bitfieldExtract
						\	bitfieldInsert
						\	bitfieldReverse
						\	ceil
						\	clamp
						\	cos
						\	cosh
						\	cross
						\	degrees
						\	determinant
						\	dFdx
						\	dFdxCoarse
						\	dFdxFine
						\	dFdy
						\	dFdyCoarse
						\	dFdyFine
						\	distance
						\	dot
						\	EmitStreamVertex
						\	EmitVertex
						\	EndPrimitive
						\	EndStreamPrimitive
						\	equal
						\	exp
						\	exp2
						\	faceforward
						\	findLSB
						\	findMSB
						\	floatBitsToInt
						\	floatBitsToUint
						\	floor
						\	fma
						\	fract
						\	frexp
						\	fwidth
						\	fwidthCoarse
						\	fwidthFine
						\	greaterThan
						\	greaterThanEqual
						\	groupMemoryBarrier
						\	imageAtomicAdd
						\	imageAtomicAnd
						\	imageAtomicCompSwap
						\	imageAtomicExchange
						\	imageAtomicMax
						\	imageAtomicMin
						\	imageAtomicOr
						\	imageAtomicXor
						\	imageLoad
						\	imageSamples
						\	imageSize
						\	imageStore
						\	imulExtended
						\	intBitsToFloat
						\	interpolateAtCentroid
						\	interpolateAtOffset
						\	interpolateAtSample 
						\	inverse
						\	inversesqrt
						\	isinf
						\	isnan
						\	ldexp
						\	length
						\	lessThan
						\	lessThanEqual
						\	log
						\	log2
						\	matrixCompMult
						\	max
						\	memoryBarrier
						\	memoryBarrierAtomicCounter
						\	memoryBarrierBuffer
						\	memoryBarrierImage
						\	memoryBarrierShared
						\	min
						\	mix
						\	mod
						\	modf
						\	noise1
						\	noise2
						\	noise3
						\	noise4
						\	normalize
						\	not
						\	notEqual
						\	outerProduct
						\	packDouble2x32
						\	packHalf2x16
						\	packSnorm2x16
						\	packSnorm4x8
						\	packUnorm2x16
						\	packUnorm4x8
						\	pow
						\	radians
						\	reflect
						\	refract
						\	round
						\	roundEven
						\	sign
						\	sin
						\	sinh
						\	smoothstep
						\	sqrt
						\	step
						\	tan
						\	tanh
						\	texelFetch
						\	texelFetchOffset
						\	texture
						\	textureGather
						\	textureGatherOffset
						\	textureGatherOffsets
						\	textureGrad
						\	textureGradOffset
						\	textureLod
						\	textureLodOffset
						\	textureOffset
						\	textureProj
						\	textureProjGrad
						\	textureProjGradOffset
						\	textureProjLod
						\	textureProjLodOffset
						\	textureProjOffset
						\	textureQueryLod
						\	textureQueryLevels
						\	textureSamples
						\	textureSize
						\	transpose
						\	trunc
						\	uaddCarry
						\	uintBitsToFloat
						\	umulExtended
						\	unpackDouble2x32
						\	unpackHalf2x16
						\	unpackSnorm2x16
						\	unpackSnorm4x8
						\	unpackUnorm2x16
						\	unpackUnorm4x8
						\	usubBorrow
						\	contained
syntax match	glslFunction	'\<all\ze\s*('	contained
syntax match	glslFuncPattern	'\<\i\+\s*('	contains=glslFunction
"}}}

" GLSL keywords {{{
syntax keyword glslConditional	if else switch
syntax keyword glslStatement	break return continue discard
syntax keyword glslLabel		case default
syntax keyword glslRepeat		while for do
syntax keyword glslStructure	struct
syntax keyword glslLayout		layout precision
" }}}

" GLSL types {{{
" transparent types
syntax keyword glslTransparentType	bool
								\	bvec2
								\	bvec3
								\	bvec4
								\	dmat2
								\	dmat2x2
								\	dmat2x3
								\	dmat2x4
								\	dmat3
								\	dmat3x2
								\	dmat3x3
								\	dmat3x4
								\	dmat4
								\	dmat4x2
								\	dmat4x3
								\	dmat4x4
								\	double
								\	dvec2
								\	dvec3
								\	dvec4
								\	float
								\	int
								\	ivec2
								\	ivec3
								\	ivec4
								\	mat2
								\	mat2x2
								\	mat2x3
								\	mat2x4
								\	mat3
								\	mat3x2
								\	mat3x3
								\	mat3x4
								\	mat4
								\	mat4x2
								\	mat4x3
								\	mat4x4
								\	uint
								\	uvec2
								\	uvec3
								\	uvec4
								\	vec2
								\	vec3
								\	vec4
								\	void

" opaque types
syntax keyword glslOpaqueType	atomic_uint
							\	iimage1D
							\	iimage1DArray
							\	iimage2D
							\	iimage2DArray
							\	iimage2DMS
							\	iimage2DMSArray
							\	iimage2DRect
							\	iimage3D
							\	iimageBuffer
							\	iimageCube
							\	iimageCubeArray
							\	image1D
							\	image1DArray
							\	image2D
							\	image2DArray
							\	image2DMS
							\	image2DMSArray
							\	image2DRect
							\	image3D
							\	imageBuffer
							\	imageCube
							\	imageCubeArray
							\	isampler1D
							\	isampler1DArray
							\	isampler2D
							\	isampler2DArray
							\	isampler2DMS
							\	isampler2DMSArray
							\	isampler2DRect
							\	isampler3D
							\	isamplerBuffer
							\	isamplerCube
							\	isamplerCubeArray
							\	sampler1D
							\	sampler1DArray
							\	sampler1DArrayShadow
							\	sampler1DShadow
							\	sampler2D
							\	sampler2DArray
							\	sampler2DMS
							\	sampler2DMSArray
							\	sampler2DArrayShadow
							\	sampler2DRect
							\	sampler2DRectShadow
							\	sampler2DShadow
							\	sampler3D
							\	samplerBuffer
							\	samplerCube
							\	samplerCubeArray
							\	samplerCubeArrayShadow
							\	samplerCubeShadow
							\	uimage1D
							\	uimage1DArray
							\	uimage2D
							\	uimage2DArray
							\	uimage2DMS
							\	uimage2DMSArray
							\	uimage2DRect
							\	uimage3D
							\	uimageBuffer
							\	uimageCube
							\	uimageCubeArray
							\	usampler1D
							\	usampler1DArray
							\	usampler2D
							\	usampler2DArray
							\	usampler2DMS
							\	usampler2DMSArray
							\	usampler2DRect
							\	usampler3D
							\	usamplerBuffer
							\	usamplerCube
							\	usamplerCubeArray
"}}}

" GLSL built in variables {{{
syntax keyword glslVariable	gl_ClipDistance
						\	gl_CullDistance
						\	gl_FragCoord
						\	gl_FragDepth
						\	gl_FrontFacing
						\	gl_GlobalInvocationID
						\	gl_HelperInvocation
						\	gl_in
						\	gl_InstanceID
						\	gl_InvocationID
						\	gl_Layer
						\	gl_LocalGroupSize
						\	gl_LocalInvocationID
						\	gl_LocalInvocationIndex
						\	gl_NumWorkGroups
						\	gl_out
						\	gl_PatchVerticesIn
						\	gl_PerVertex
						\	gl_PointCoord
						\	gl_PointSize
						\	gl_Position
						\	gl_PrimitiveID
						\	gl_PrimitiveIDIn
						\	gl_SampleID
						\	gl_SampleMask
						\	gl_SampleMaskIn
						\	gl_SamplePosition
						\	gl_TessCoord
						\	gl_TessLevelInner
						\	gl_TessLevelOuter
						\	gl_VertexID
						\	gl_ViewportIndex
						\	gl_WorkGroupID
						\	gl_WorkGroupSize
"}}}

" GLSL qualifiers {{{
syntax keyword	glslQualifier	align
							\	binding
							\	buffer
							\	ccw
							\	centroid
							\	coherent
							\	column_major
							\	component
							\	const
							\	cw
							\	depth_any
							\	depth_greater
							\	depth_less
							\	depth_unchanged
							\	early_fragment_tests
							\	equal_spacing
							\	flat
							\	fractional_even_spacing
							\	fractional_odd_spacing
							\	highp
							\	in
							\	index
							\	inout
							\	invariant
							\	invocations
							\	isolines
							\	line_strip
							\	lines
							\	lines_adjacency
							\	local_size_x
							\	local_size_y
							\	local_size_z
							\	location
							\	lowp
							\	max_vertices
							\	mediump
							\	offset
							\	origin_upper_left
							\	out
							\	noperspective
							\	offset
							\	packed
							\	patch
							\	pixel_center_integer
							\	point_mode
							\	points
							\	precise
							\	quads
							\	readonly
							\	restrict
							\	row_major
							\	sampler
							\	shared
							\	smooth
							\	std140
							\	std430
							\	stream
							\	triangle_strip
							\	triangles
							\	triangles_adjacency
							\	uniform
							\	vertices
							\	volatile
							\	writeonly
							\	xfb_buffer
							\	xfb_offset
							\	xfb_stride

syntax keyword	glslQualFormat	r11f_g11f_b10f
							\	r16
							\	r16_snorm
							\	r16f
							\	r16i
							\	r16ui
							\	r32f
							\	r32i
							\	r32ui
							\	r8
							\	r8_snorm
							\	r8i
							\	r8ui
							\	rg16
							\	rg16_snorm
							\	rg16f
							\	rg16i
							\	rg16ui
							\	rg32f
							\	rg32i
							\	rg32ui
							\	rg8
							\	rg8_snorm
							\	rg8i
							\	rg8ui
							\	rgb10_a2i
							\	rgb10_a2u
							\	rgba16
							\	rgba16_snorm
							\	rgba16f
							\	rgba16i
							\	rgba16ui
							\	rgba32f
							\	rgba32i
							\	rgba32ui
							\	rgba8
							\	rgba8_snorm
							\	rgba8i
							\	rgba8ui
"}}}

" GLSL vector components {{{
" use ms=s+1 to not highlight the period
syntax match   glslComponent   '\.[xyzw]\+\>'ms=s+1
syntax match   glslComponent   '\.[rgba]\+\>'ms=s+1
syntax match   glslComponent   '\.[stpq]\+\>'ms=s+1

" avoid mixing spacial components with color and texture
"
" it is erroneous to mix components from different conceptual
" types. now, it is feasible that some permutation of these
" letters could be used for a struct field. if such occurs in
" your shaders, you should link glslMixedComps to something
" other than Error.
syntax match	glslMixedComps	'\.[rgbastpq]\+[xyzw]\+[rgbastpq]*'ms=s+1
syntax match	glslMixedComps	'\.[rgbastpq]*[xyzw]\+[rgbastpq]\+'ms=s+1

" avoid mixing color with spacial and texture
syntax match	glslMixedComps	'\.[xyzwstpq]\+[rgba]\+[xyzwstpq]*'ms=s+1
syntax match	glslMixedComps	'\.[xyzwstpq]*[rgba]\+[xyzwstpq]\+'ms=s+1

" avoid mixing texture with spacial and color
syntax match	glslMixedComps	'\.[xyzwrgba]\+[stpq]\+[xyzwrgba]*'ms=s+1
syntax match	glslMixedComps	'\.[xyzwrgba]*[stpq]\+[xyzwrgba]\+'ms=s+1
"}}}

" GLSL preprocessor {{{
" built in macros
syntax keyword	glslMacro	__LINE__
						\	__FILE__
						\	__VERSION__
						\	GL_compatibility_profile
						\	GL_core_profile
						\	GL_es_profile

" macro definition
syntax match	glslDefine	'^\s*#\s*\(define\|undef\)\>'

" preprocessor conditionals
syntax region	glslPrecondition	start='^\s*#\s*\(if\|ifdef\|ifndef\|elif\)\>'
							\		skip='\\$'
							\		end='$'
							\		keepend contains=glslComment,glslNumbers
syntax match	glslPrecondition	'^\s*#\s*\(else\|endif\)\>'

" pragmas
syntax keyword	glslPragmaOptions	optimize debug STDGL	contained
syntax match	glslPragmaValues	'(\s*\zs\(all\|off\|on\)\ze\s*)'
syntax region	glslPragma			start='^\s*#\s*pragma\>'
						\			skip='\\$'
						\			end='$'
						\			keepend contains=glslPragmaValues,glslPragmaOptions,glslQualifier

" extensions
syntax keyword	glslExtBehavior	disable enable require warn contained
syntax match	glslExtAll		'\s\+\zsall\ze\s*:'			contained
syntax match	glslExtension	'^\s*#\s*extension\s\+\i\+\s*:\s*\(disable\|enable\|require\|warn\)'
							\	contains=glslExtAll,glslExtBehavior

" versioning
syntax keyword	glslProfile	core compatibility es
syntax region	glslVersion	start='^\s*#\s*version\>\s*\d\d\d\>'
						\	skip='\\$'
						\	end='$'
						\	keepend contains=glslProfile,glslNumbers

" diagnostics
syntax region	glslLine	start='^\s*#\s*line\>'
					\		skip='\\$'
					\		end='$'
					\		keepend contains=glslNumber
syntax match	glslErrorString	'".*"' contained
syntax region	glslError		start='^\s*#\s*error\>'
						\		skip='\\$'
						\		end='$'
						\		keepend contains=glslErrorString
"}}}

" GLSL errors {{{
syntax match glslReserved 'gl_\i*'
" }}}

" Define the default highlighting. {{{
highlight default link glslBoolean			Constant
highlight default link glslComment			Comment
highlight default link glslComponent		Special
highlight default link glslConditional		Conditional
highlight default link glslConstant			Constant
highlight default link glslDefine			PreProc
highlight default link glslError			PreProc
highlight default link glslErrorString		String
highlight default link glslExtAll			Keyword
highlight default link glslExtBehavior		Constant
highlight default link glslExtension		PreProc
highlight default link glslFloat			Number
highlight default link glslFunction			Identifier
highlight default link glslHexZero			PreProc
highlight default link glslLabel			Label
highlight default link glslLayout			Keyword
highlight default link glslLine				PreProc
highlight default link glslMacro			Macro
highlight default link glslMixedComps		Error
highlight default link glslNumber			Number
highlight default link glslOctal			Number
highlight default link glslOctalError		Error
highlight default link glslOctalZero		PreProc
highlight default link glslOpaqueType		Type
highlight default link glslPragma			PreProc
highlight default link glslPragmaOptions	Keyword
highlight default link glslPragmaValues		Constant
highlight default link glslPrecondition		PreCondit
highlight default link glslProfile			Keyword
highlight default link glslQualFormat		Constant
highlight default link glslQualifier		StorageClass
highlight default link glslRepeat			Repeat
highlight default link glslReserved			Error
highlight default link glslStatement		Statement
highlight default link glslStructure		Structure
highlight default link glslTodo				Todo
highlight default link glslTransparentType	Type
highlight default link glslVariable			Identifier
highlight default link glslVersion			PreProc
"}}}

let b:current_syntax = 'glsl'

