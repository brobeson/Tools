" Vim syntax file
" Language:	OpenGL Shader Language (GLSL)
" Maintainer:	Brendan Robeson (ogslanger@vt.edu)
" Last Change:	2014 June 3
"
" This is the base file for GLSL shaders.  It contains syntax definitions
" common to all the shader types.  Thanks to Bram Moolenaar for c.vim, on
" which this is based.

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

"============================================================
"   GLSL numbers
"============================================================
" TODO
" - the floats using scientific notation do not color the decimal point
" ignore case for the type suffixes: f and F are both ok.
syntax case ignore
syntax match	glslNumbers		"\<\d\|\.\d"	transparent contains=glslInteger,glslFloat,glslOctalError,glslOctal,glslHex

" decimal integers
syntax match	glslInteger		"\d\+u\="		contained

" hex number
syntax match	glslHexZero		"\<0x"			contained
syntax match	glslHex			"0x\x\+u\="		contained contains=glslHexZero

" flag the first zero of an octal number as something special
syntax match	glslOctalZero	"\<0"			contained
syntax match	glslOctal		"0\o\+u\=\>"	contained contains=glslOctalZero
syntax match	glslOctalError	"0\o*[89]\d*"	contained

" floating point numbers
syntax match	glslFloat		"\d\+\(f\|lf\)"							contained
syntax match	glslFloat		"\d\+\.\d*\(e[-+]\=\d\+\)\=\(f\|lf\)"	contained
syntax match	glslFloat		"\.\d\+\(e[-+]\=\d\+\)\=\(f\|lf\)=\>"	contained
syntax match	glslFloat		"\d\+e[-+]\=\d\+\(f\|lf\)\=\>"			contained

" restore case sensitivity
syntax case match
"============================================================


"============================================================
"   GLSL comments
"============================================================
" glslCommentGroup allows adding matches for special things in comments
syntax cluster	glslCommentGroup	contains=glslTodo,cBadContinuation
syntax keyword	glslTodo			TODO FIXME XXX HACK BUG			contained 
syntax region	glslComment			start="//"  skip="\\$" end="$"	keepend contains=@glslCommentGroup,glslTrailingSpace
syntax region	glslComment			start="/\*"            end="\*/"
syntax match	glslCommentError	"\*/"
"============================================================


"============================================================
"   GLSL built in constants
"============================================================
syntax keyword glslBoolean		true false
syntax keyword glslConstant		gl_MaxAtomicCounterBindings               gl_MaxAtomicCounterBufferSize           gl_MaxClipDistances
syntax keyword glslConstant		gl_MaxCombinedAtomicCounterBuffers        gl_MaxCombinedAtomicCounters            gl_MaxCombinedImageUnitsAndFragmentOutputs
syntax keyword glslConstant		gl_MaxCombinedImageUniforms               gl_MaxCombinedTextureImageUnits         gl_MaxComputeAtomicGounterBuffers
syntax keyword glslConstant		gl_MaxComputeAtomicCounters               gl_MaxComputeImageUniforms              gl_MaxComputeTextureImageUnits
syntax keyword glslConstant		gl_MaxComputeUniformComponents            gl_MaxComputeWorkGroupCount             gl_MaxComputeWorkGroupSize
syntax keyword glslConstant		gl_MaxProgramTexelOffset                  gl_MinProgramTexelOffset                gl_MaxDrawBuffers
syntax keyword glslConstant		gl_MaxFragmentAtomicCounterBuffers        gl_MaxFragmentAtomicCounters            gl_MaxFragmentImageUniforms
syntax keyword glslConstant		gl_MaxFragmentInputComponents             gl_MaxFragmentUniformComponents         gl_MaxFragmentUniformVectors
syntax keyword glslConstant		gl_MaxGeometryAtomicCounterBuffers        gl_MaxGeometryAtomicCounters            gl_MaxGeometryImageUniforms
syntax keyword glslConstant		gl_MaxGeometryInputComponents             gl_MaxGeometryOutputComponents          gl_MaxGeometryOutputVertices
syntax keyword glslConstant		gl_MaxGeometryTextureImageUnits           gl_MaxGeometryTotalOutputComponents     gl_MaxGeometryUniformComponents
syntax keyword glslConstant		gl_MaxGeometryVaryingComponents           gl_MaxIMageSamples                      gl_MaxImageUnits
syntax keyword glslConstant		gl_MaxPatchVertices                       gl_MaxTessControlAtomicCounterBuffers   gl_MaxTessControlAtomicCounters
syntax keyword glslConstant		gl_MaxTessControlImageUniforms            gl_MaxTessControlInputComponents        gl_MaxTessControlOutputComponents
syntax keyword glslConstant		gl_MaxTessControlTextureImageUnits        gl_MaxTessControlTotalOutputComponents  gl_MaxTessControlUniformComponents
syntax keyword glslConstant		gl_MaxTessEvaluationAtomicCounterBuffers  gl_MaxTessEvaluationAtomicCounters      gl_MaxTessEvaluationImageUniforms
syntax keyword glslConstant		gl_MaxTessEvaluationInputComponents       gl_MaxTessEvaluationOutputComponents    gl_MaxTessEvaluationTextureImageUnits
syntax keyword glslConstant		gl_MaxTessEvaluationUniformComponents     gl_MaxTessGenLevel                      gl_MaxTessPatchComponents
syntax keyword glslConstant		gl_MaxTextureImageUnits                   gl_MaxTransformFeedbackBuffers          gl_MaxTransformFeedbackInterleavedComponents
syntax keyword glslConstant		gl_MaxVaryingComponents                   gl_MaxVaryingVectors                    gl_MaxVertexAtomicCounterBuffers
syntax keyword glslConstant		gl_MaxVertexAtomicCounters                gl_MaxVertexAttribs                     gl_MaxVertexImageUniforms
syntax keyword glslConstant		gl_MaxVertexOutputComponents              gl_MaxVertexTextureImageUnits           gl_MaxVertexUniformComponents
syntax keyword glslConstant		gl_MaxVertexUniformVectors                gl_MaxViewports
"============================================================


"============================================================
"   GLSL built in functions
"============================================================
" trig
syntax keyword glslFunction		radians degrees sin cos tan asin acos atan sinh cosh tanh asinh acosh atanh

" exponential
syntax keyword glslFunction		pow exp log exp2 log2 sqrt inversesqrt

" other
syntax keyword glslFunction		abs sign floor trunc round roundEven ceil fract mod modf min max clamp mix step smoothstep isnan isinf floatBitsToInt intBitsToFloat fma frexp ldexp
syntax keyword glslFunction		barrier memoryBarrier groupMemoryBarrier memoryBarrierAtomicCounter memoryBarrierShared memoryBarrierBuffer memoryBarrierImage

" packing
syntax keyword glslFunction		packUnorm2x16 packUnorm4x8 unpackUnorm2x16 unpackUnorm4x8 packDouble2x32 unpackDouble2x32 packHalf2x16 unpackHalf2x16

" geometric
syntax keyword glslFunction		length distance dot cross normalize faceforward reflect refract

" matrices
syntax keyword glslFunction		matrixCompMult outerProduct transpose determinant inverse

" vector relations
syntax keyword glslFunction		lessThan lessThanEqual greaterThan greaterThanEqual equal notEqual any all not

" integers
syntax keyword glslFunction		uaddCarry usubBorrow umulExtended imulExtended bitfieldExtract bitfieldReverse bitfieldInsert bitCount findLSB findMSB

" atomic counters & memory ops
syntax keyword glslFunction		atomicCounterIncrement atomicCounterDecrement atomicCounter atomicOP

" image functions
syntax keyword glslFunction		imageSize imageLoad imageStore imageAtomicAdd imageAtomicMin imageAtomicMax imageAtomicAnd imageAtomicOr imageAtomicXor imageAtomicExchange imageAtomicCompSwap
"============================================================


"============================================================
"   GLSL looping, logic control, etc.
"============================================================
syntax keyword glslConditional	if else switch
syntax keyword glslLabel		case default
syntax keyword glslRepeat		while for do
syntax keyword glslControl		break return continue
"============================================================


"============================================================
"   GLSL interface blocks
"============================================================
syntax keyword glslLayout	layout shared packed std140 std430 row_major column_major
"============================================================


"============================================================
"   GLSL invariance
"============================================================
syntax keyword glslInvariance	invariant precise
"============================================================


"============================================================
"   GLSL types
"============================================================
syntax keyword	glslType	vec2        vec3       vec4
syntax keyword	glslType	dvec2       dvec3      dvec4
syntax keyword	glslType	bvec2       bvec3      bvec4
syntax keyword	glslType	ivec2       ivec3      ivec4
syntax keyword	glslType	uvec2       uvec3      uvec4
syntax keyword	glslType	mat2        mat3       mat4
syntax keyword	glslType	mat2x2      mat2x3     mat2x4
syntax keyword	glslType	mat3x2      mat3x3     mat3x4
syntax keyword	glslType	mat4x2      mat4x3     mat4x4
syntax keyword	glslType	dmat2       dmat3      dmat4
syntax keyword	glslType	dmat2x2     dmat2x3    dmat2x4
syntax keyword	glslType	dmat3x2     dmat3x3    dmat3x4
syntax keyword	glslType	dmat4x2     dmat4x3    dmat4x4
syntax keyword	glslType	void        bool       int        uint         float          double
syntax keyword	glslType	sampler1D   sampler2D  sampler3D  samplerCube  sampler2DRect  sampler1DArray  sampler2DArray  samplerBuffer  sampler2DMS  sampler2DMSArray  samplerCubeArray sampler1DShadow sampler2DShadow sampler2DRectShadow sampler1DArrayShadow sampler2DArrayShadow samplerCubeShadow samplerCubeArrayShadow
syntax keyword	glslType	isampler1D  isampler2D isampler3D isamplerCube isampler2DRect isampler1DArray isampler2DArray isamplerBuffer isampler2DMS isampler2DMSArray isamplerCubeArray
syntax keyword	glslType	usampler1D  usampler2D usampler3D usamplerCube usampler2DRect usampler1DArray usampler2DArray usamplerBuffer usampler2DMS usampler2DMSArray usamplerCubeArray
syntax keyword	glslType	image1D     image2D    image3D    imageCube    image2DRect    image1DArray    image2DArray    imageBuffer    image2DMS    image2DMSArray    imageCubeArray
syntax keyword	glslType	iimage1D    iimage2D   iimage3D   iimageCube   iimage2DRect   iimage1DArray   iimage2DArray   iimageBuffer   iimage2DMS   iimage2DMSArray   iimageCubeArray
syntax keyword	glslType	uimage1D    uimage2D   uimage3D   uimageCube   uimage2DRect   uimage1DArray   uimage2DArray   uimageBuffer   uimage2DMS   uimage2DMSArray   uimageCubeArray
syntax keyword	glslType	atomic_uint
syntax keyword	glslType	struct
"============================================================


"============================================================
"   GLSL shader stage specific
"============================================================
" these all default to show an error.  the correct shader
" stage syntax file will reset it's items to render correctly.
syntax keyword glslNotAllowed	gl_ClipDistance   gl_FragCoord     gl_FragDepth       gl_FrontFacing    gl_GlobalInvocationID gl_in
syntax keyword glslNotAllowed	gl_InstanceID     gl_InvocationID  gl_Layer           gl_LocalGroupSize gl_LocalInvocationID  gl_LocalInvocationIndex
syntax keyword glslNotAllowed	gl_NumWorkGroups  gl_out           gl_PatchVerticesIn gl_PerVertex      gl_PointCoord         gl_PointSize
syntax keyword glslNotAllowed	gl_Position       gl_PrimitiveID   gl_PrimitiveIDIn   gl_SampleID       gl_SampleMask         gl_SampleMaskIn
syntax keyword glslNotAllowed	gl_SamplePosition gl_TessCoord     gl_TessLevelInner  gl_TessLevelOuter gl_ViewportIndex      gl_VertexID
syntax keyword glslNotAllowed	gl_WorkGroupID    gl_WorkGroupSize discard

" fragment, geometry, and vertex processing
syntax keyword glslNotAllowed	noise1

" fragment processing
syntax keyword glslNotAllowed	dFdx dFdy fwidth interpolateAtCentroid interpolateAtSample interpolateAtOffset

" geometry processing
syntax keyword glslNotAllowed	EmitStreamVertex EndStreamPrimitive EmitVertex EndPrimitive

" texture functions (available in vertex, geometry & fragment shaders)
syntax keyword glslNotAllowed	textureSize           textureQueryLod       textureQueryLevels texture textureProj  textureLod           textureOffset texelFetch
syntax keyword glslNotAllowed	texelFetchOffset      textureProjOffset     textureLodOffset   textureProjLod       textureProjLodOffset textureGrad   textureGradOffset
syntax keyword glslNotAllowed	textureProjGrad       textureProjGradOffset textureGather      textureGatherOffset  textureGatherOffsets

" we cannot include "shared" here, because it is valid in all
" shaders as a layout qualifier.
"============================================================


"============================================================
"   GLSL qualifiers
"============================================================
syn keyword glslQualifier   const    in        out           inout    uniform   buffer shared
syn keyword glslQualifier   centroid sampler   patch
syn keyword glslQualifier   smooth   flat      noperspective
syn keyword glslQualifier   coherent volatile  restrict      readonly writeonly
syn keyword glslQualifier   precise  invariant
"============================================================


"============================================================
"   GLSL vector components
"============================================================
" use ms=s+1 to not highlight the period
syntax match   glslComponent   "\.[xyzw]\+\>"ms=s+1
syntax match   glslComponent   "\.[rgba]\+\>"ms=s+1
syntax match   glslComponent   "\.[stpq]\+\>"ms=s+1

" it is erroneous to mix components from different conceptual
" types. now, it is feasible that some permutation of these
" letters could be used for a struct field. if such occurs in
" your shaders, you can comment these lines.
"
" avoid mixing spacial components with color and texture
syntax match	glslCompError	"\.[rgbastpq]\+[xyzw]\+[rgbastpq]*"ms=s+1
syntax match	glslCompError	"\.[rgbastpq]*[xyzw]\+[rgbastpq]\+"ms=s+1

" avoid mixing color with spacial and texture
syntax match	glslCompError	"\.[xyzwstpq]\+[rgba]\+[xyzwstpq]*"ms=s+1
syntax match	glslCompError	"\.[xyzwstpq]*[rgba]\+[xyzwstpq]\+"ms=s+1

" avoid mixing texture with spacial and color
syntax match	glslCompError	"\.[xyzwrgba]\+[stpq]\+[xyzwrgba]*"ms=s+1
syntax match	glslCompError	"\.[xyzwrgba]*[stpq]\+[xyzwrgba]\+"ms=s+1
"============================================================


"============================================================
"   GLSL preprocessor
"============================================================
" TODO
" - extension name can't currently be colored differently
"
" built in macros
syntax keyword	glslMacro			__LINE__ __FILE__ __VERSION__ GL_core_profile GL_es_profile GL_compatibility_profile

" macro definition
syntax region	glslDefine			start="^\s*#\s*\(define\|undef\)\>"				skip="\\$" end="$"	keepend contains=ALLBUT

" preprocessor conditionals
syntax region	glslPrecondition	start="^\s*#\s*\(if\|ifdef\|ifndef\|elif\)\>"	skip="\\$" end="$"	keepend contains=glslComment,glslcParenError,glslNumbers,glslCommentError,glslTrailingSpace
syntax match	glslPrecondition	"^\s*#\s*\(else\|endif\)\>"

" compiler control
syntax keyword	glslPragmaDirs		optimize debug STDGL												contained
syntax keyword	glslPragmaValues	on off																contained
syntax region	glslPragma			start="^\s*#\s*pragma\>"						skip="\\$" end="$"	keepend contains=glslPragmaDirs,glslPragmaValues
"syntax match	glslExtName			".\+"																contained
syntax keyword	glslExtDir			require enable warn disable											contained
syntax match	glslExtension		"^\s*#\s*extension\>.\+:\s\(require\|enable\|warn\|disable\)"		contains=glslExtName,glslExtDir

" versioning
syntax keyword	glslProfile			core compatibility es
syntax region	glslVersion			start="^\s*#\s*version\>\s*\d\d\d\>"			skip="\\$" end="$"	keepend contains=glslComment,glslProfile,glslNumbers

" diagnostics
syntax region	glslPreprocessor	start="^\s*#\s*\(line\>\|error\>\)"				skip="\\$" end="$"	keepend contains=ALLBUT
"============================================================


"============================================================
"	GLSL parenthesis errors
"============================================================
"catch errors caused by wrong parenthesis and brackets
"
" This should be before glslErrInParen to avoid problems with #define ({ xxx })
" TODO	this is not working
"if exists("glsl_curly_error")
"    syntax match	glslCurlyError	"}"
"    syntax region	glslBlock		start="{" end="}" contains=ALLBUT,glslCurlyError,@glslParenGroup,glslErrorInParen,glslErrorInBracket fold
"else
"    syntax region	glslBlock		start="{" end="}" transparent fold
"endif

syntax cluster	glslParenGroup		contains=glslParenError,@glslCommentGroup,glslOctalZero,glslNumber,glslFloat,glslOctal,glslOctalError
syntax region	glslParenthesis		start='(' end=')'	transparent contains=ALLBUT,@glslParenGroup,glslErrorInBracket
syntax match	glslParenError		"[\])]"				display
syntax match	glslErrorInParen	"[\]{}]"			display contained
syntax region	glslBracket			start='\[' end=']'	transparent contains=ALLBUT,@glslParenGroup,glslErrorInParen
syntax match	glslErrorInBracket	"[);{}]"			display contained
"============================================================


"============================================================
"	GLSL miscellaneous
"============================================================
" when wanted, highlight trailing white space
" TODO	this ain't working...
"if exists("glsl_space_errors")
"	syntax match	glslTrailingSpace	display excludenl "\s\+$"
"	syntax match	glslTrailingSpace	display " \+\t"me=e-1
"endif
"============================================================



" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link glslBoolean				Constant
hi def link glslComment				Comment
hi def link glslCommentError		Error
hi def link glslCommentStartError	Error
hi def link glslCompError			Error
hi def link glslComponent			Special
hi def link glslConditional			Conditional
hi def link glslConstant			Constant
hi def link glslCurlyError			Error
hi def link glslDefine				Macro
hi def link glslErrorInBracket		Error
hi def link glslErrorInParen		Error
hi def link glslExtDir				Keyword
hi def link glslExtension			PreProc
hi def link glslExtName				Constant
hi def link glslFloat				Number
hi def link glslFunction			Keyword
hi def link glslHex					Number
hi def link glslHexZero				PreProc
hi def link glslInteger				Number
hi def link glslInvariant			Keyword
hi def link glslLabel				Label
hi def link glslLayout				Keyword
hi def link glslMacro				Macro
hi def link glslNotAllowed			Error
hi def link glslOctal				Number
hi def link glslOctalError			Error
hi def link glslOctalZero			PreProc
hi def link glslParenError			Error
hi def link glslPragma				PreProc
hi def link glslPragmaDirs			Keyword
hi def link glslPragmaValues		Constant
hi def link glslPrecondition		PreCondit
hi def link glslPreprocessor		PreProc
hi def link glslProfile				Keyword
hi def link glslQualifier			StorageClass
hi def link glslRepeat				Repeat
hi def link glslTodo				Todo
hi def link glslTrailingSpace		Error
hi def link glslType				Type
hi def link glslVersion				PreProc

let b:current_syntax = "glsl"

