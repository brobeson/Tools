" Vim completion script
" Language:     OpenGL Shading Language (GLSL)
" Maintainer:   Brendan Robeson (https://github.com/brobeson/glslVim)
" Last Change:  2016 May 29

let s:cpo_save = &cpo
set cpo&vim

" GLSL built ins {{{
" start with the macros (kind = d)
let s:glsl_builtins = [
    \ { 'kind': 'f',    'word': 'abs(',
    \                   'abbr': 'abs',
    \                   'info': "\/\/ return the absolute value of x\n" .
    \                           "genType abs(genType x);\n\n" },
    \ { 'kind': 'f',    'word': 'acos(',
    \                   'abbr': 'acos',
    \                   'info': "\/\/ calculate the arccosine of x\n" .
    \                           "\/\/ the result is undefined if abs(x) > 1\n" .
    \                           "\/\/ param[in] x: the value for which to calculate the arccosine\n" .
    \                           "\/\/              should be on [-1, 1]\n" .
    \                           "\/\/ returns   the arccosine, in radians on [0, pi], of x\n" .
    \                           "genType acos(genType x);\n\n" },
    \ { 'kind': 'd', 'word': '__FILE__',                 'abbr': '__FILE__',                 'info': "\/\/ Integer representing the current source string" },
    \ { 'kind': 'd', 'word': '__LINE__',                 'abbr': '__LINE__',                 'info': "\/\/ The line number where the macro is used" },
    \ { 'kind': 'd', 'word': '__VERSION__',              'abbr': '__VERSION__',              'info': "\/\/ Integer representing the GLSL version used" },
    \ { 'kind': 'v', 'word': 'gl_ClipDistance',          'abbr': 'gl_ClipDistance',          'info': "\/\/ tessallation control, tessallation evaulation, geometry:\n" .
                                                                                                    \"\/\/     the distance from the vertex to each clipping half-space\n" .
                                                                                                    \"\/\/ fragment: the interpolated clipping plane half-spaces\n" .
                                                                                                    \"in float gl_ClipDistance[];\n\n" .
                                                                                                    \"\/\/ vertex, tessallation control, tessallation evaluation, geometry:\n" .
                                                                                                    \"\/\/     the distance from the vertex to each clipping half-space\n" .
                                                                                                    \"out float gl_ClipDistance[];" },
    \ { 'kind': 'd', 'word': 'GL_compatibility_profile', 'abbr': 'GL_compatibility_profile', 'info': "\/\/ Defined as 1 if the shader profile was set to \"compatibility\"" },
    \ { 'kind': 'd', 'word': 'GL_core_profile',          'abbr': 'GL_core_profile',          'info': "\/\/ Defined as 1 if the shader profile was set to \"core\"" },
    \ { 'kind': 'v', 'word': 'gl_CullDistance',          'abbr': 'gl_CullDistance',          'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/     no documentation available\n" .
                                                                                                    \"out float gl_CullDistance[];\n\n" .
                                                                                                    \"\/\/ tessallation control & evaluation, geometry, fragment:\n" .
                                                                                                    \"\/\/     no documentation available\n" .
                                                                                                    \"in float gl_CullDistance[];" },
    \ { 'kind': 'd', 'word': 'GL_es_profile',            'abbr': 'GL_es_profile',            'info': "\/\/ Defined as 1 if the shader profile was set \"es\"" },
    \ { 'kind': 'v', 'word': 'gl_FragCoord',             'abbr': 'gl_FragCoord',             'info': "\/\/ fragment: the fragment's location in window space\n" .
                                                                                                    \"in vec4 gl_FragCoord;" },
    \ { 'kind': 'v', 'word': 'gl_FragDepth',             'abbr': 'gl_FragDepth',             'info': "\/\/ fragment: The depth of the fragment\n" .
                                                                                                    \"out float gl_FragDepth;" },
    \ { 'kind': 'v', 'word': 'gl_FrontFacing',           'abbr': 'gl_FrontFacing',           'info': "\/\/ fragment: true if the fragment is front facing, false if it is\n" .
                                                                                                    \"\/\/           back facing\n" .
                                                                                                    \"in bool gl_FrontFacing;" },
    \ { 'kind': 'v', 'word': 'gl_GlobalInvocationID',    'abbr': 'gl_GlobalInvocationID',    'info': "\/\/ compute input: the unique ID for an invocation of a compute\n" .
                                                                                                    \"\/\/                shader, with a work group\n" .
                                                                                                    \"in uvec3 gl_GlobalInvocationID;" },
    \ { 'kind': 'v', 'word': 'gl_HelperInvocation',      'abbr': 'gl_HelperInvocation',      'info': "\/\/ fragment: no documentation available\n" .
                                                                                                    \"in bool gl_HelperInvocation;" },
    \ { 'kind': 'v', 'word': 'gl_in',                    'abbr': 'gl_in',                    'info': "\/\/ tessallation control, tessallation evaluation, geometry:\n" .
                                                                                                    \"\/\/     the instance of gl_PerVertex\n" .
                                                                                                    \"in gl_PerVertex { /*...*/ } gl_in[];" },
    \ { 'kind': 'v', 'word': 'gl_InstanceID',            'abbr': 'gl_InstanceID',            'info': "\/\/ vertex: the index of the current instance when using instanced\n" .
                                                                                                    \"\/\/         rendering, 0 otherwise\n" .
                                                                                                    \"in int gl_InstanceID;" },
    \ { 'kind': 'v', 'word': 'gl_InvocationID',          'abbr': 'gl_InvocationID',          'info': "\/\/ tessallation control: the index of the TCS invocation in this patch\n" .
                                                                                                    \"\/\/ geometry input: the current instance\n" .
                                                                                                    \"in int gl_InvocationID;\n" },
    \ { 'kind': 'v', 'word': 'gl_Layer',                 'abbr': 'gl_Layer',                 'info': "\/\/ geometry: the layer to which a primitive goes\n" . 
                                                                                                    \"out int gl_Layer;\n\n" .
                                                                                                    \"\/\/ fragment: the layer for the fragment, output by the geometry shader\n" .
                                                                                                    \"in int gl_Layer;" },
    \ { 'kind': 'v', 'word': 'gl_LocalGroupSize',        'abbr': 'gl_LocalGroupSize',        'info': "\/\/ compute: no documentation available\n" .
                                                                                                    \"in uvec3 gl_LocalGroupSize;" },
    \ { 'kind': 'v', 'word': 'gl_LocalInvocationID',     'abbr': 'gl_LocalInvocationID',     'info': "\/\/ compute: the current invocation of the shader within the work group\n" .
                                                                                                    \"in uvec3 gl_LocalInvocationID;" },
    \ { 'kind': 'v', 'word': 'gl_LocalInvocationIndex',  'abbr': 'gl_LocalInvocationIndex',  'info': "\/\/ compute: the (1-D) index of the shader invocation within the work group\n" .
                                                                                                    \"in uint gl_LocalInvocationIndex;" },
    \ { 'kind': 'v', 'word': 'gl_NumWorkGroups',         'abbr': 'gl_NumWorkGroups',         'info': "\/\/ compute: the number of work groups used when dispatching the compute shader\n" .
                                                                                                    \"in uvec3 gl_NumWorkGroups;" },
    \ { 'kind': 'v', 'word': 'gl_out',                   'abbr': 'gl_out',                   'info': "\/\/ tessalation control: the instance of gl_PerVertex for output\n" .
                                                                                                    \"out gl_PerVertex { /*...*/ } gl_out[];" },
    \ { 'kind': 'v', 'word': 'gl_PatchVerticesIn',       'abbr': 'gl_PatchVerticesIn',       'info': "\/\/ tessallation control & evaluation: the number of vertices in the\n" .
                                                                                                    \"\/\/                                    input patch\n" .
                                                                                                    \"in int gl_PatchVerticesIn;" },
    \ { 'kind': 'v', 'word': 'gl_PerVertex',             'abbr': 'gl_PerVertex',             'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/     an unnamed interface block for per vertex output\n" .
                                                                                                    \"out gl_PerVertex { /*...*/ };\n\n" .
                                                                                                    \"\/\/ tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/     an unnamed interface block for per vertex input\n" .
                                                                                                    \"in gl_PerVertex { /*...*/ };" },
    \ { 'kind': 'v', 'word': 'gl_PointCoord',            'abbr': 'gl_PointCoord',            'info': "\/\/ fragment: the location of a fragment within a point primitive\n" .
                                                                                                    \"in vec2 gl_PointCoord;" },
    \ { 'kind': 'v', 'word': 'gl_PointSize',             'abbr': 'gl_PointSize',             'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/    the pixel width and height of the point being rasterized\n" .
                                                                                                    \"out float gl_PointSize;\n\n" .
                                                                                                    \"\/\/ tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/    the pixel width and height of the point being rasterized\n" .
                                                                                                    \"in float gl_PointSize;" },
    \ { 'kind': 'v', 'word': 'gl_Position',              'abbr': 'gl_Position',              'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/    the clipping space output position of the vertex\n" .
                                                                                                    \"out vec4 gl_Position;\n\n" .
                                                                                                    \"\/\/ tessallation control & evaluation, geometry:\n" .
                                                                                                    \"\/\/    the clipping space input position of the vertex\n" .
                                                                                                    \"int vec4 gl_Position;" },
    \ { 'kind': 'v', 'word': 'gl_PrimitiveID',           'abbr': 'gl_PrimitiveID',           'info': "\/\/ tessallation control: the index of the current patch\n" .
                                                                                                    \"\/\/ fragment: the index of the current primitive\n" .
                                                                                                    \"in int gl_PrimitiveID;\n\n" .
                                                                                                    \"\/\/ geometry output: the primitive ID to send to the fragement shader\n" .
                                                                                                    \"out int gl_PrimitiveID;" },
    \ { 'kind': 'v', 'word': 'gl_PrimitiveIDIn',         'abbr': 'gl_PrimitiveIDIn',         'info': "\/\/ geometry: the ID of the current input primitive\n" .
                                                                                                    \"in int gl_PrimitiveIDIn;" },
    \ { 'kind': 'v', 'word': 'gl_SampleID',              'abbr': 'gl_SampleID',              'info': "\/\/ fragment: the ID of the current sample within a fragment\n" .
                                                                                                    \"in int gl_SampleID;" },
    \ { 'kind': 'v', 'word': 'gl_SampleMask',            'abbr': 'gl_SampleMask',            'info': "\/\/ fragment: the sample mask for the fragment, when using\n" .
                                                                                                    \"\/\/           multisampled rendering\n" .
                                                                                                    \"out int gl_SampleMask[];" },
    \ { 'kind': 'v', 'word': 'gl_SampleMaskIn',          'abbr': 'gl_SampleMaskIn',          'info': "\/\/ fragment: bitfield for the sample mask of the current fragment\n" .
                                                                                                    \"in int gl_SampleMaskIn[];" },
    \ { 'kind': 'v', 'word': 'gl_SamplePosition',        'abbr': 'gl_SamplePosition',        'info': "\/\/ fragment: the location of the current sample within the current fragment\n" .
                                                                                                    \"in vec2 gl_SamplePosition;" },
    \ { 'kind': 'v', 'word': 'gl_TessCoord',             'abbr': 'gl_TessCoord',             'info': "\/\/ tessallation evaluation: the location of a vertex within the\n" .
                                                                                                    \"\/\/                          tessallated abstract patch\n" .
                                                                                                    \"in vec3 gl_TessCoord;" },
    \ { 'kind': 'v', 'word': 'gl_TessLevelInner',        'abbr': 'gl_TessLevelInner',        'info': "\/\/ tessallation control: the inner tessallation level\n" .
                                                                                                    \"patch out float gl_TessLevelInner[2];\n\n" .
                                                                                                    \"\/\/ tessallation evaluation: the inner tessallation level from the\n" .
                                                                                                    \"\/\/                          tessallation control shader\n" .
                                                                                                    \"patch in float gl_TessLevelInner[2];" },
    \ { 'kind': 'v', 'word': 'gl_TessLevelOuter',        'abbr': 'gl_TessLevelOuter',        'info': "\/\/ tessallation control: the outer tessallation level\n" .
                                                                                                    \"patch out float gl_TessLevelOuter[4];\n\n" .
                                                                                                    \"\/\/ tessallation evaluation: the outer tessallation level from the\n" .
                                                                                                    \"\/\/                          tessallation control shader\n" .
                                                                                                    \"patch in float gl_TessLevelOuter[4];" },
    \ { 'kind': 'v', 'word': 'gl_VertexID',              'abbr': 'gl_VertexID',              'info': "\/\/ vertex: the index of the vertex currently being processed\n" .
                                                                                                    \"in int gl_VertexID;" },
    \ { 'kind': 'v', 'word': 'gl_ViewportIndex',         'abbr': 'gl_ViewportIndex',         'info': "\/\/ geometry: specifies which viewport to use for the primitive\n" .
                                                                                                    \"out int gl_ViewportIndex;\n\n" .
                                                                                                    \"\/\/ fragment: 0, or the viewport index for the primitive from the\n" .
                                                                                                    \"\/\/           geometry shader\n" .
                                                                                                    \"in  int gl_ViewportIndex;" },
    \ { 'kind': 'v', 'word': 'gl_WorkGroupID',           'abbr': 'gl_WorkGroupID',           'info': "\/\/ compute: the current work group for the shader invocation\n" .
                                                                                                    \"in uvec3 gl_WorkGroupID;" },
    \ { 'kind': 'v', 'word': 'gl_WorkGroupSize',         'abbr': 'gl_WorkGroupSize',         'info': "\/\/ compute: the size of the local work group\n" .
                                                                                                    \"const uvec3 gl_WorkGroupSize;" }
    \ ]
" }}}

" GLSL built in constants {{{
let s:constants =   [   "gl_MaxAtomicCounterBindings",
                    \   "gl_MaxAtomicCounterBufferSize",
                    \   "gl_MaxClipDistances",
                    \   "gl_MaxCombinedAtomicCounterBuffers",
                    \   "gl_MaxCombinedAtomicCounters",
                    \   "gl_MaxCombinedClipAndCullDistances",
                    \   "gl_MaxCombinedImageUnitsAndFragmentOutputs",
                    \   "gl_MaxCombinedImageUniforms",
                    \   "gl_MaxCombinedShaderOutputResources",
                    \   "gl_MaxCombinedTextureImageUnits",
                    \   "gl_MaxComputeAtomicGounterBuffers",
                    \   "gl_MaxComputeAtomicCounters",
                    \   "gl_MaxComputeImageUniforms",
                    \   "gl_MaxComputeTextureImageUnits",
                    \   "gl_MaxComputeUniformComponents",
                    \   "gl_MaxComputeWorkGroupCount",
                    \   "gl_MaxComputeWorkGroupSize",
                    \   "gl_MaxCullDistances",
                    \   "gl_MaxProgramTexelOffset",
                    \   "gl_MaxDrawBuffers",
                    \   "gl_MaxFragmentAtomicCounterBuffers",
                    \   "gl_MaxFragmentAtomicCounters",
                    \   "gl_MaxFragmentImageUniforms",
                    \   "gl_MaxFragmentInputComponents",
                    \   "gl_MaxFragmentUniformComponents",
                    \   "gl_MaxFragmentUniformVectors",
                    \   "gl_MaxGeometryAtomicCounterBuffers",
                    \   "gl_MaxGeometryAtomicCounters",
                    \   "gl_MaxGeometryImageUniforms",
                    \   "gl_MaxGeometryInputComponents",
                    \   "gl_MaxGeometryOutputComponents",
                    \   "gl_MaxGeometryOutputVertices",
                    \   "gl_MaxGeometryTextureImageUnits",
                    \   "gl_MaxGeometryTotalOutputComponents",
                    \   "gl_MaxGeometryUniformComponents",
                    \   "gl_MaxGeometryVaryingComponents",
                    \   "gl_MaxImageSamples",
                    \   "gl_MaxImageUnits",
                    \   "gl_MaxPatchVertices",
                    \   "gl_MaxSamples",
                    \   "gl_MaxTessControlAtomicCounterBuffers",
                    \   "gl_MaxTessControlAtomicCounters",
                    \   "gl_MaxTessControlImageUniforms",
                    \   "gl_MaxTessControlInputComponents",
                    \   "gl_MaxTessControlOutputComponents",
                    \   "gl_MaxTessControlTextureImageUnits",
                    \   "gl_MaxTessControlTotalOutputComponents",
                    \   "gl_MaxTessControlUniformComponents",
                    \   "gl_MaxTessEvaluationAtomicCounterBuffers",
                    \   "gl_MaxTessEvaluationAtomicCounters",
                    \   "gl_MaxTessEvaluationImageUniforms",
                    \   "gl_MaxTessEvaluationInputComponents",
                    \   "gl_MaxTessEvaluationOutputComponents",
                    \   "gl_MaxTessEvaluationTextureImageUnits",
                    \   "gl_MaxTessEvaluationUniformComponents",
                    \   "gl_MaxTessGenLevel",
                    \   "gl_MaxTessPatchComponents",
                    \   "gl_MaxTextureImageUnits",
                    \   "gl_MaxTransformFeedbackBuffers",
                    \   "gl_MaxTransformFeedbackInterleavedComponents",
                    \   "gl_MaxVaryingComponents",
                    \   "gl_MaxVaryingVectors",
                    \   "gl_MaxVertexAtomicCounterBuffers",
                    \   "gl_MaxVertexAtomicCounters",
                    \   "gl_MaxVertexAttribs",
                    \   "gl_MaxVertexImageUniforms",
                    \   "gl_MaxVertexOutputComponents",
                    \   "gl_MaxVertexTextureImageUnits",
                    \   "gl_MaxVertexUniformComponents",
                    \   "gl_MaxVertexUniformVectors",
                    \   "gl_MaxViewports",
                    \   "gl_MinProgramTexelOffset" ]
"}}}

" GLSL built in functions {{{
    \ { 'kind': 'f',    'word': 'abs(',
    \                   'abbr': 'abs',
    \                   'info': "\/\/ return the absolute value of x\n" .
    \                           "genType abs(genType x);" },
    \ { 'kind': 'f',    'word': 'acos(',
    \                   'abbr': 'acos',
    \                   'info': "\/\/ calculate the arccosine of x\n" .
    \                           "\/\/ the result is undefined if abs(x) > 1\n" .
    \                           "\/\/ param[in] x: the value for which to calculate the arccosine\n" .
    \                           "\/\/              should be on [-1, 1]\n" .
    \                           "\/\/ returns   the arccosine, in radians on [0, pi], of x\n" .
    \                           "genType acos(genType angle);\n\n" },
    \ { 'kind': 'f',    'word': 'acosh(',
    \                   'abbr': 'acosh',
    \                   'info': "\/\/ return the arc hyperbolic cosine of x\n" .
    \                           "\/\/ the result is undefined if x < 1\n" .
    \                           "genType acosh(genType x);" },
    \ { 'kind': 'f',    'word': 'any(',
    \                   'abbr': 'any',
    \                   'info': "\/\/ \n" .
    \                           "any();" },
    \ { 'kind': 'f',    'word': 'asin(',
    \                   'abbr': 'asin',
    \                   'info': "\/\/ return the arcsine, in radians, of x\n" .
    \                           "\/\/ the range of arcsine is [-pi/2, pi/2]\n" .
    \                           "\/\/ the result is undefined if abs(x) > 1\n" .
    \                           "genType asin(genType x);" },
    \ { 'kind': 'f',    'word': 'asinh(',
    \                   'abbr': 'asinh',
    \                   'info': "\/\/ return the arc hyperbolic sine of x\n" .
    \                           "genType asinh(genType x);" },
    \ { 'kind': 'f',    'word': 'atan(',
    \                   'abbr': 'atan',
    \                   'info': "\/\/ return the arctangent, in radians, of y / x\n" .
    \                           "\/\/ the signs of y and x are used to determine the angle's quadrant\n" .
    \                           "\/\/ the range of this arctangent overload is [-pi, pi]\n" .
    \                           "\/\/ the result is undefined if x == 0\n" .
    \                           "genType atan(genType y, genType x);\n\n" .
    \                           "\/\/ return the arctangent, in radians, of y_over_x\n" .
    \                           "\/\/ the range of this arctangent overload is [-pi/2, pi/2]\n" .
    \                           "genType atan(genType y_over_x);" },
    \ { 'kind': 'f',    'word': 'atanh(',
    \                   'abbr': 'atanh',
    \                   'info': "\/\/ return the arc hyperbolic tangent of x\n" .
    \                           "\/\/ the results is undefined if abs(x) > 1\n" .
    \                           "genType atanh(genType x);" },
    \ { 'kind': 'f',    'word': 'atomicAdd(',
    \                   'abbr': 'atomicAdd',
    \                   'info': "\/\/ perform an atomic addition to a variable\n" .
    \                           "\/\/ the operation is similar to mem += data;\n" .
    \                           "\/\/ param[in,out] mem:  the target variable for the atomic addition\n" .
    \                           "\/\/ param[in]     data: the data to be added to mem\n" .
    \                           "int  atomicAdd(inout int  mem, int  data);\n" .
    \                           "uint atomicAdd(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicAnd(',
    \                   'abbr': 'atomicAnd',
    \                   'info': "\/\/ perform an atomic logical AND operation on a variable\n" .
    \                           "\/\/ the operation is similar to mem = mem && data;\n" .
    \                           "\/\/ param[in,out] mem:  the target variable for the atomic AND\n" .
    \                           "\/\/ param[in]     data: the data to be ANDed with mem\n" .
    \                           "int  atomicAnd(inout int  mem, int  data);\n" .
    \                           "uint atomicAnd(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicCompSwap(',
    \                   'abbr': 'atomicCompSwap',
    \                   'info': "\/\/ perform an atomic compare & exchange operation on a variable\n" .
    \                           "\/\/ mem = (mem == compare ? data : mem);\n" .
    \                           "\/\/ param[in,out] mem: the target variable of the operation\n" .
    \                           "\/\/ param[in]     compare:\n" .
    \                           "\/\/ param[in]     data:    the data to be compared, and possible exchanged, with mem\n" .
    \                           "int  atomicCompSwap(inout int  mem, int  compare, int  data);\n" .
    \                           "uint atomicCompSwap(inout uint mem, uint compare, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicCounter(',
    \                   'abbr': 'atomicCounter',
    \                   'info': "\/\/ return the value of an atomic counter, specified by the handle c\n" .
    \                           "uint atomicCounter(atomic_uint c);" },
    \ { 'kind': 'f',    'word': 'atomicCounterDecrement(',
    \                   'abbr': 'atomicCounterDecrement',
    \                   'info': "\/\/ atomically decrement the atomic counter associated with handle c\n" .
    \                           "\/\/ returns the value of the counter prior to decrementing\n" .
    \                           "uint atomicCounterDecrement(atomic_uint c);" },
    \ { 'kind': 'f',    'word': 'atomicCounterIncrement(',
    \                   'abbr': 'atomicCounterIncrement',
    \                   'info': "\/\/ atomically increment the atomic counter associated with handle c\n" .
    \                           "\/\/ returns the value of the counter prior to incrementing\n" .
    \                           "uint atomicCounterIncrement(atomic_uint c);" },
    \ { 'kind': 'f',    'word': 'atomicExchange(',
    \                   'abbr': 'atomicExchange',
    \                   'info': "\/\/ perform an atomic exchange operation on a variable\n" .
    \                           "\/\/ the value of data is written to mem, and the original value of mem is returned\n" .
    \                           "int  atomicExchange(inout int  mem, int  data);\n" .
    \                           "uint atomicExchange(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicMax(',
    \                   'abbr': 'atomicMax',
    \                   'info': "\/\/ perform an atomic max operation on a variable\n" .
    \                           "\/\/ mem = max(mem, data);\n" .
    \                           "\/\/ the original value of mem is returned\n" .
    \                           "int  atomicMax(inout int  mem, int  data);\n" .
    \                           "uint atomicMax(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicMin(',
    \                   'abbr': 'atomicMin',
    \                   'info': "\/\/ perform an atomic min operation on a variable\n" .
    \                           "\/\/ mem = min(mem, data);\n" .
    \                           "\/\/ the original value of mem is returned\n" .
    \                           "int  atomicMin(inout int  mem, int  data);\n" .
    \                           "uint atomicMin(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicOr(',
    \                   'abbr': 'atomicOr',
    \                   'info': "\/\/ perform an atomic logical OR operation on a variable\n" .
    \                           "\/\/ the operation is similar to mem = mem && data;\n" .
    \                           "\/\/ param[in,out] mem:  the target variable for the atomic OR\n" .
    \                           "\/\/ param[in]     data: the data to be ORed with mem\n" .
    \                           "int  atomicOr(inout int  mem, int  data);\n" .
    \                           "uint atomicOr(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'atomicXor(',
    \                   'abbr': 'atomicXor',
    \                   'info': "\/\/ perform an atomic logical exclusive OR operation on a variable\n" .
    \                           "\/\/ the operation is similar to mem = mem && data;\n" .
    \                           "\/\/ param[in,out] mem:  the target variable for the atomic exclusive OR\n" .
    \                           "\/\/ param[in]     data: the data to be ORed with mem\n" .
    \                           "int  atomicXor(inout int  mem, int  data);\n" .
    \                           "uint atomicXor(inout uint mem, uint data);" },
    \ { 'kind': 'f',    'word': 'barrier(',
    \                   'abbr': 'barrier',
    \                   'info': "\/\/ synchronize execution of multiple shader invocations\n" .
    \                           "\/\/ only available to tessallation control and compute shaders\n" .
    \                           "void barrier();" },
    \ { 'kind': 'f',    'word': 'bitCount(',
    \                   'abbr': 'bitCount',
    \                   'info': "\/\/ \n" .
    \                           "bitCount();" },
    \ { 'kind': 'f',    'word': 'bitfieldExtract(',
    \                   'abbr': 'bitfieldExtract',
    \                   'info': "\/\/ \n" .
    \                           "bitfieldExtract();" },
    \ { 'kind': 'f',    'word': 'bitfieldInsert(',
    \                   'abbr': 'bitfieldInsert',
    \                   'info': "\/\/ \n" .
    \                           "bitfieldInsert();" },
    \ { 'kind': 'f',    'word': 'bitfieldReverse(',
    \                   'abbr': 'bitfieldReverse',
    \                   'info': "\/\/ \n" .
    \                           "bitfieldReverse();" },
    \ { 'kind': 'f',    'word': 'ceil(',
    \                   'abbr': 'ceil',
    \                   'info': "\/\/ return the nearest integer >= x\n" .
    \                           "genType  ceil(genType  x);\n" .
    \                           "genDType ceil(genDType x);" },
    \ { 'kind': 'f',    'word': 'clamp(',
    \                   'abbr': 'clamp',
    \                   'info': "\/\/ constrain a value to a specific range\n" .
    \                           "genType  clamp(genType  x, genType  minVal, genType  maxVal);\n" .
    \                           "genType  clamp(genType  x, float    minVal, float    maxVal);\n" .
    \                           "genDType clamp(genDType x, genDType minVal, genDType maxVal);\n" .
    \                           "genDType clamp(genDType x, double   minVal, double   maxVal);\n" .
    \                           "genIType clamp(genIType x, genIType minVal, genIType maxVal);\n" .
    \                           "genIType clamp(genIType x, int      minVal, int      maxVal);\n" .
    \                           "genUType clamp(genUType x, genUType minVal, genUType maxVal);\n" .
    \                           "genUType clamp(genUType x, uint     minVal, uint     maxVal);" },
    \ { 'kind': 'f',    'word': 'cos(',
    \                   'abbr': 'cos',
    \                   'info': "\/\/ return the cosine of the given angle\n" .
    \                           "\/\/ angle must be in radians\n" .
    \                           "genType cos(genType angle);" },
    \ { 'kind': 'f',    'word': 'cosh(',
    \                   'abbr': 'cosh',
    \                   'info': "\/\/ return the hyperbolic cosine of x\n" .
    \                           "\/\/ the formula is (e^x + e^-x) / 2\n" .
    \                           "genType cosh(genType x);" },
    \ { 'kind': 'f',    'word': 'cross(',
    \                   'abbr': 'cross',
    \                   'info': "\/\/ \n" .
    \                           "cross();" },
    \ { 'kind': 'f',    'word': 'degrees(',
    \                   'abbr': 'degrees',
    \                   'info': "\/\/ convert from radians to degrees\n" .
    \                           "genType degrees(genType radians);" },
    \ { 'kind': 'f',    'word': 'determinant(',
    \                   'abbr': 'determinant',
    \                   'info': "\/\/ \n" .
    \                           "determinant();" },
    \ { 'kind': 'f',    'word': 'dFdx(',
    \                   'abbr': 'dFdx',
    \                   'info': "\/\/ \n" .
    \                           "dFdx();" },
    \ { 'kind': 'f',    'word': 'dFdxCoarse(',
    \                   'abbr': 'dFdxCoarse',
    \                   'info': "\/\/ \n" .
    \                           "dFdxCoarse();" },
    \ { 'kind': 'f',    'word': 'dFdxFine(',
    \                   'abbr': 'dFdxFine',
    \                   'info': "\/\/ \n" .
    \                           "dFdxFine();" },
    \ { 'kind': 'f',    'word': 'dFdy(',
    \                   'abbr': 'dFdy',
    \                   'info': "\/\/ \n" .
    \                           "dFdy();" },
    \ { 'kind': 'f',    'word': 'dFdyCoarse(',
    \                   'abbr': 'dFdyCoarse',
    \                   'info': "\/\/ \n" .
    \                           "dFdyCoarse();" },
    \ { 'kind': 'f',    'word': 'dFdyFine(',
    \                   'abbr': 'dFdyFine',
    \                   'info': "\/\/ \n" .
    \                           "dFdyFine();" },
    \ { 'kind': 'f',    'word': 'distance(',
    \                   'abbr': 'distance',
    \                   'info': "\/\/ \n" .
    \                           "distance();" },
    \ { 'kind': 'f',    'word': 'dot(',
    \                   'abbr': 'dot',
    \                   'info': "\/\/ \n" .
    \                           "dot();" },
    \ { 'kind': 'f',    'word': 'EmitStreamVertex(',
    \                   'abbr': 'EmitStreamVertex',
    \                   'info': "\/\/ \n" .
    \                           "EmitStreamVertex();" },
    \ { 'kind': 'f',    'word': 'EmitVertex(',
    \                   'abbr': 'EmitVertex',
    \                   'info': "\/\/ \n" .
    \                           "EmitVertex();" },
    \ { 'kind': 'f',    'word': 'EndPrimitive(',
    \                   'abbr': 'EndPrimitive',
    \                   'info': "\/\/ \n" .
    \                           "EndPrimitive();" },
    \ { 'kind': 'f',    'word': 'EndStreamPrimitive(',
    \                   'abbr': 'EndStreamPrimitive',
    \                   'info': "\/\/ \n" .
    \                           "EndStreamPrimitive();" },
    \ { 'kind': 'f',    'word': 'equal(',
    \                   'abbr': 'equal',
    \                   'info': "\/\/ \n" .
    \                           "equal();" },
    \ { 'kind': 'f',    'word': 'exp(',
    \                   'abbr': 'exp',
    \                   'info': "\/\/ return e to the x power\n" .
    \                           "genType exp(genType x);" },
    \ { 'kind': 'f',    'word': 'exp2(',
    \                   'abbr': 'exp2',
    \                   'info': "\/\/ return 2 to the x power\n" .
    \                           "genType exp2(genType x);" },
    \ { 'kind': 'f',    'word': 'faceforward(',
    \                   'abbr': 'faceforward',
    \                   'info': "\/\/ \n" .
    \                           "faceforward();" },
    \ { 'kind': 'f',    'word': 'findLSB(',
    \                   'abbr': 'findLSB',
    \                   'info': "\/\/ \n" .
    \                           "findLSB();" },
    \ { 'kind': 'f',    'word': 'findMSB(',
    \                   'abbr': 'findMSB',
    \                   'info': "\/\/ \n" .
    \                           "findMSB();" },
    \ { 'kind': 'f',    'word': 'floatBitsToInt(',
    \                   'abbr': 'floatBitsToInt',
    \                   'info': "\/\/ return the encoding of a floating point value as an integer\n" .
    \                           "genIType floatBitsToInt(genType x);" },
    \ { 'kind': 'f',    'word': 'floatBitsToUint(',
    \                   'abbr': 'floatBitsToUint',
    \                   'info': "\/\/ return the encoding of a floating point value as an unsigned integer\n" .
    \                           "genUType floatBitsToUint(genType x);" },
    \ { 'kind': 'f',    'word': 'floor(',
    \                   'abbr': 'floor',
    \                   'info': "\/\/ return the nearest integer <= x\n" .
    \                           "genType  floor(genType  x);\n" .
    \                           "genDType floor(genDType x);" },
    \ { 'kind': 'f',    'word': 'fma(',
    \                   'abbr': 'fma',
    \                   'info': "\/\/ perform a fused multiply add operation: a * b + c\n" .
    \                           "\/\/ when using precise, the following conditions hold:\n" .
    \                           "\/\/ 1) fma() is a single operation,\n" .
    \                           "\/\/ 2) the precision of fma() can differ from a * b + c\n" .
    \                           "\/\/ 3) is invariant with other precise calls to fma() with the same parameters\n" .
    \                           "genType  fma(genType  a, genType  b, genType  c);\n" .
    \                           "genDType fma(genDType a, genDType b, genDType c);" },
    \ { 'kind': 'f',    'word': 'fract(',
    \                   'abbr': 'fract',
    \                   'info': "\/\/ return the fractional part of x: x - floor(x)\n" .
    \                           "genType  fract(genType  x);\n" .
    \                           "genDType fract(genDType x);" },
    \ { 'kind': 'f',    'word': 'frexp(',
    \                   'abbr': 'frexp',
    \                   'info': "\/\/ split a floating point value into its significand and exponent\n" .
    \                           "\/\/ the split occurs such that x = significand * 2^exp\n" .
    \                           "\/\/ x is the floating point value to split\n" .
    \                           "\/\/ exp is the exponent output from the fucntion\n" .
    \                           "\/\/ returns the significant on the range [0.5, 1.0]\n" .
    \                           "\/\/ the results are undefined if x is NaN or infinity\n" .
    \                           "genType  frexp(genType  x, out genIType exp);\n" .
    \                           "genDType frexp(genDType x, out genIType exp);" },
    \ { 'kind': 'f',    'word': 'fwidth(',
    \                   'abbr': 'fwidth',
    \                   'info': "\/\/ \n" .
    \                           "fwidth();" },
    \ { 'kind': 'f',    'word': 'fwidthCoarse(',
    \                   'abbr': 'fwidthCoarse',
    \                   'info': "\/\/ \n" .
    \                           "fwidthCoarse();" },
    \ { 'kind': 'f',    'word': 'fwidthFine(',
    \                   'abbr': 'fwidthFine',
    \                   'info': "\/\/ \n" .
    \                           "fwidthFine();" },
    \ { 'kind': 'f',    'word': 'greaterThan(',
    \                   'abbr': 'greaterThan',
    \                   'info': "\/\/ \n" .
    \                           "greaterThan();" },
    \ { 'kind': 'f',    'word': 'greaterThanEqual(',
    \                   'abbr': 'greaterThanEqual',
    \                   'info': "\/\/ \n" .
    \                           "greaterThanEqual();" },
    \ { 'kind': 'f',    'word': 'groupMemoryBarrier(',
    \                   'abbr': 'groupMemoryBarrier',
    \                   'info': "\/\/ \n" .
    \                           "groupMemoryBarrier();" },
    \ { 'kind': 'f',    'word': 'imageAtomicAdd(',
    \                   'abbr': 'imageAtomicAdd',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicAdd();" },
    \ { 'kind': 'f',    'word': 'imageAtomicAnd(',
    \                   'abbr': 'imageAtomicAnd',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicAnd();" },
    \ { 'kind': 'f',    'word': 'imageAtomicCompSwap(',
    \                   'abbr': 'imageAtomicCompSwap',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicCompSwap();" },
    \ { 'kind': 'f',    'word': 'imageAtomicExchange(',
    \                   'abbr': 'imageAtomicExchange',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicExchange();" },
    \ { 'kind': 'f',    'word': 'imageAtomicMax(',
    \                   'abbr': 'imageAtomicMax',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicMax();" },
    \ { 'kind': 'f',    'word': 'imageAtomicMin(',
    \                   'abbr': 'imageAtomicMin',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicMin();" },
    \ { 'kind': 'f',    'word': 'imageAtomicOr(',
    \                   'abbr': 'imageAtomicOr',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicOr();" },
    \ { 'kind': 'f',    'word': 'imageAtomicXor(',
    \                   'abbr': 'imageAtomicXor',
    \                   'info': "\/\/ \n" .
    \                           "imageAtomicXor();" },
    \ { 'kind': 'f',    'word': 'imageLoad(',
    \                   'abbr': 'imageLoad',
    \                   'info': "\/\/ \n" .
    \                           "imageLoad();" },
    \ { 'kind': 'f',    'word': 'imageSamples(',
    \                   'abbr': 'imageSamples',
    \                   'info': "\/\/ \n" .
    \                           "imageSamples();" },
    \ { 'kind': 'f',    'word': 'imageSize(',
    \                   'abbr': 'imageSize',
    \                   'info': "\/\/ \n" .
    \                           "imageSize();" },
    \ { 'kind': 'f',    'word': 'imageStore(',
    \                   'abbr': 'imageStore',
    \                   'info': "\/\/ \n" .
    \                           "imageStore();" },
    \ { 'kind': 'f',    'word': 'imulExtended(',
    \                   'abbr': 'imulExtended',
    \                   'info': "\/\/ \n" .
    \                           "imulExtended();" },
    \ { 'kind': 'f',    'word': 'intBitsToFloat(',
    \                   'abbr': 'intBitsToFloat',
    \                   'info': "\/\/ return a floating point value using the supplied integer as the encoding\n" .
    \                           "genType intBitsToFloat(genIType x);" },
    \ { 'kind': 'f',    'word': 'interpolateAtCentroid(',
    \                   'abbr': 'interpolateAtCentroid',
    \                   'info': "\/\/ \n" .
    \                           "interpolateAtCentroid();" },
    \ { 'kind': 'f',    'word': 'interpolateAtOffset(',
    \                   'abbr': 'interpolateAtOffset',
    \                   'info': "\/\/ \n" .
    \                           "interpolateAtOffset();" },
    \ { 'kind': 'f',    'word': 'interpolateAtSample (',
    \                   'abbr': 'interpolateAtSample ',
    \                   'info': "\/\/ \n" .
    \                           "interpolateAtSample ();" },
    \ { 'kind': 'f',    'word': 'inverse(',
    \                   'abbr': 'inverse',
    \                   'info': "\/\/ \n" .
    \                           "inverse();" },
    \ { 'kind': 'f',    'word': 'inversesqrt(',
    \                   'abbr': 'inversesqrt',
    \                   'info': "\/\/ return the inverse square root of x: 1 / sqrt(x)\n" .
    \                           "\/\/ the result is undefined if x <= 0\n" .
    \                           "genType  inversesqrt(genType  x);\n" .
    \                           "genDType inversesqrt(genDType x);" },
    \ { 'kind': 'f',    'word': 'isinf(',
    \                   'abbr': 'isinf',
    \                   'info': "\/\/ determine if the given value is positive or negative infinity\n" .
    \                           "\/\/ for each component c of x, returns true if x.c is infinity, and false otherwise\n" .
    \                           "genBType isinf(genType  x);\n" .
    \                           "genBType isinf(genDType x);" },
    \ { 'kind': 'f',    'word': 'isnan(',
    \                   'abbr': 'isnan',
    \                   'info': "\/\/ determine if the given value is a number\n" .
    \                           "\/\/ for each component c of x, returns true if x.c is NaN, and false otherwise\n" .
    \                           "genBType isnan(genType  x);\n" .
    \                           "genBType isnan(genDType x);" },
    \ { 'kind': 'f',    'word': 'ldexp(',
    \                   'abbr': 'ldexp',
    \                   'info': "\/\/ return a floating point value created from a significand and exponent\n" .
    \                           "\/\/ the value is calculated as x * 2^exp\n" .
    \                           "\/\/ the result is undefined if it is too large to fit in the floating point type\n" .
    \                           "genType  ldexp(genType  x, genIType exp);\n" .
    \                           "genDType ldexp(genDType x, genIType exp);" },
    \ { 'kind': 'f',    'word': 'length(',
    \                   'abbr': 'length',
    \                   'info': "\/\/ \n" .
    \                           "length();" },
    \ { 'kind': 'f',    'word': 'lessThan(',
    \                   'abbr': 'lessThan',
    \                   'info': "\/\/ \n" .
    \                           "lessThan();" },
    \ { 'kind': 'f',    'word': 'lessThanEqual(',
    \                   'abbr': 'lessThanEqual',
    \                   'info': "\/\/ \n" .
    \                           "lessThanEqual();" },
    \ { 'kind': 'f',    'word': 'log(',
    \                   'abbr': 'log',
    \                   'info': "\/\/ return the natural logarithm of x\n" .
    \                           "\/\/ the result is undefined if x <= 0\n" .
    \                           "genType log(genType x);" },
    \ { 'kind': 'f',    'word': 'log2(',
    \                   'abbr': 'log2',
    \                   'info': "\/\/ return the base 2 logarithm of x\n" .
    \                           "\/\/ the result is undefined if x <= 0\n" .
    \                           "genType log2(genType x);" },
    \ { 'kind': 'f',    'word': 'matrixCompMult(',
    \                   'abbr': 'matrixCompMult',
    \                   'info': "\/\/ \n" .
    \                           "matrixCompMult();" },
    \ { 'kind': 'f',    'word': 'max(',
    \                   'abbr': 'max',
    \                   'info': "\/\/ return the maximum of two values\n" .
    \                           "genType  max(genType  x, genType  y);\n" .
    \                           "genType  max(genType  x, float    y);\n" .
    \                           "genDType max(genDType x, genDType y);\n" .
    \                           "genDType max(genDType x, double   y);\n" .
    \                           "genIType max(genIType x, genIType y);\n" .
    \                           "genIType max(genIType x, int      y);\n" .
    \                           "genUType max(genUType x, genUType y);\n" .
    \                           "genUType max(genUType x, uint     y);" },
    \ { 'kind': 'f',    'word': 'memoryBarrier(',
    \                   'abbr': 'memoryBarrier',
    \                   'info': "\/\/ \n" .
    \                           "memoryBarrier();" },
    \ { 'kind': 'f',    'word': 'memoryBarrierAtomicCounter(',
    \                   'abbr': 'memoryBarrierAtomicCounter',
    \                   'info': "\/\/ \n" .
    \                           "memoryBarrierAtomicCounter();" },
    \ { 'kind': 'f',    'word': 'memoryBarrierBuffer(',
    \                   'abbr': 'memoryBarrierBuffer',
    \                   'info': "\/\/ \n" .
    \                           "memoryBarrierBuffer();" },
    \ { 'kind': 'f',    'word': 'memoryBarrierImage(',
    \                   'abbr': 'memoryBarrierImage',
    \                   'info': "\/\/ \n" .
    \                           "memoryBarrierImage();" },
    \ { 'kind': 'f',    'word': 'memoryBarrierShared(',
    \                   'abbr': 'memoryBarrierShared',
    \                   'info': "\/\/ \n" .
    \                           "memoryBarrierShared();" },
    \ { 'kind': 'f',    'word': 'min(',
    \                   'abbr': 'min',
    \                   'info': "\/\/ return the minimum of two values\n" .
    \                           "genType  min(genType  x, genType  y);\n" .
    \                           "genType  min(genType  x, float    y);\n" .
    \                           "genDType min(genDType x, genDType y);\n" .
    \                           "genDType min(genDType x, double   y);\n" .
    \                           "genIType min(genIType x, genIType y);\n" .
    \                           "genIType min(genIType x, int      y);\n" .
    \                           "genUType min(genUType x, genUType y);\n" .
    \                           "genUType min(genUType x, uint     y);" },
    \ { 'kind': 'f',    'word': 'mix(',
    \                   'abbr': 'mix',
    \                   'info': "\/\/ linearly interpolate between x and y\n" .
    \                           "\/\/ a is the interpolation value\n" .
    \                           "\/\/ the formula is x(1-a) + ya\n" .
    \                           "genType  mix(genType  x, genType  y, genType  a);\n" .
    \                           "genType  mix(genType  x, genType  y, float    a);\n" .
    \                           "genDType mix(genDType x, genDType y, genDType a);\n" .
    \                           "genDType mix(genDType x, genDType y, double   a);\n\n" .
    \                           "\/\/ select components fro x and y based on a\n" .
    \                           "\/\/ for each component c, this is essentially a.c ? y.c : x.c\n" .
    \                           "genType  mix(genType  x, genType  y, genBType a);\n" .
    \                           "genDType mix(genDType x, genDType y, genBType a);\n" .
    \                           "genIType mix(genIType x, genIType y, genBType a);\n" .
    \                           "genUType mix(genUType x, genUType y, genBType a);\n" .
    \                           "genBType mix(genBType x, genBType y, genBType a);" },
    \ { 'kind': 'f',    'word': 'mod(',
    \                   'abbr': 'mod',
    \                   'info': "\/\/ return x modulo y\n" .
    \                           "\/\/ the formula is x - y * floor(x/y)\n" .
    \                           "genType  mod(genType  x, float    y);\n" .
    \                           "genType  mod(genType  x, genType  y);\n" .
    \                           "genDType mod(genDType x, double   y);\n" .
    \                           "genDType mod(genDType x, genDType y);" },
    \ { 'kind': 'f',    'word': 'modf(',
    \                   'abbr': 'modf',
    \                   'info': "\/\/ separate x into its integer and fractional components\n" .
    \                           "\/\/     x - the value to separate\n" .
    \                           "\/\/ out i - the integer component of x\n" .
    \                           "\/\/ returns the fractional component of x\n" .
    \                           "genType  modf(genType  x, out genType  i);\n" .
    \                           "genDType modf(genDType x, out genDType i);" },
    \ { 'kind': 'f',    'word': 'noise1(',
    \                   'abbr': 'noise1',
    \                   'info': "\/\/ \n" .
    \                           "noise1();" },
    \ { 'kind': 'f',    'word': 'noise2(',
    \                   'abbr': 'noise2',
    \                   'info': "\/\/ \n" .
    \                           "noise2();" },
    \ { 'kind': 'f',    'word': 'noise3(',
    \                   'abbr': 'noise3',
    \                   'info': "\/\/ \n" .
    \                           "noise3();" },
    \ { 'kind': 'f',    'word': 'noise4(',
    \                   'abbr': 'noise4',
    \                   'info': "\/\/ \n" .
    \                           "noise4();" },
    \ { 'kind': 'f',    'word': 'normalize(',
    \                   'abbr': 'normalize',
    \                   'info': "\/\/ \n" .
    \                           "normalize();" },
    \ { 'kind': 'f',    'word': 'not(',
    \                   'abbr': 'not',
    \                   'info': "\/\/ \n" .
    \                           "not();" },
    \ { 'kind': 'f',    'word': 'notEqual(',
    \                   'abbr': 'notEqual',
    \                   'info': "\/\/ \n" .
    \                           "notEqual();" },
    \ { 'kind': 'f',    'word': 'outerProduct(',
    \                   'abbr': 'outerProduct',
    \                   'info': "\/\/ \n" .
    \                           "outerProduct();" },
    \ { 'kind': 'f',    'word': 'packDouble2x32(',
    \                   'abbr': 'packDouble2x32',
    \                   'info': "\/\/ \n" .
    \                           "packDouble2x32();" },
    \ { 'kind': 'f',    'word': 'packHalf2x16(',
    \                   'abbr': 'packHalf2x16',
    \                   'info': "\/\/ \n" .
    \                           "packHalf2x16();" },
    \ { 'kind': 'f',    'word': 'packSnorm2x16(',
    \                   'abbr': 'packSnorm2x16',
    \                   'info': "\/\/ pack 2 floating point values into an unsigned integer\n" .
    \                           "\/\/ the first component is packed into the 8 LSBs\n" .
    \                           "\/\/ the last component is packed into the 8 MSBs\n" .
    \                           "\/\/ v is a vector of values to pack\n" .
    \                           "\/\/ return round(clamp(v, -1.0, 1.0) * 32767.0);\n" .
    \                           "uint packSnorm2x16(vec2 v);" },
    \ { 'kind': 'f',    'word': 'packSnorm4x8(',
    \                   'abbr': 'packSnorm4x8',
    \                   'info': "\/\/ pack 4 floating point values into an unsigned integer\n" .
    \                           "\/\/ the first component is packed into the 8 LSBs\n" .
    \                           "\/\/ the last component is packed into the 8 MSBs\n" .
    \                           "\/\/ the second and third components are packed into the corresponding bits\n" .
    \                           "\/\/ v is a vector of values to pack\n" .
    \                           "\/\/ return round(clamp(v, -1.0, 1.0) * 127.0);\n" .
    \                           "uint packSnorm4x8(vec4 v);" },
    \ { 'kind': 'f',    'word': 'packUnorm2x16(',
    \                   'abbr': 'packUnorm2x16',
    \                   'info': "\/\/ pack 2 floating point values into an unsigned integer\n" .
    \                           "\/\/ the first component is packed into the 8 LSBs\n" .
    \                           "\/\/ the last component is packed into the 8 MSBs\n" .
    \                           "\/\/ v is a vector of values to pack\n" .
    \                           "\/\/ return round(clamp(v, 0.0, 1.0) * 65535.0);\n" .
    \                           "uint packUnorm2x16(vec2 v);" },
    \ { 'kind': 'f',    'word': 'packUnorm4x8(',
    \                   'abbr': 'packUnorm4x8',
    \                   'info': "\/\/ pack 4 floating point values into an unsigned integer\n" .
    \                           "\/\/ the first component is packed into the 8 LSBs\n" .
    \                           "\/\/ the last component is packed into the 8 MSBs\n" .
    \                           "\/\/ the second and third components are packed into the corresponding bits\n" .
    \                           "\/\/ v is a vector of values to pack\n" .
    \                           "\/\/ return round(clamp(v, 0.0, 1.0) * 255.0);\n" .
    \                           "uint packUnorm2x16(vec4 v);" },
    \ { 'kind': 'f',    'word': 'pow(',
    \                   'abbr': 'pow',
    \                   'info': "\/\/ return x to the y power\n" .
    \                           "\/\/ the result is undefined if x < 0, or if x == 0 and y <= 0\n" .
    \                           "genType pow(genType x, genType y);" },
    \ { 'kind': 'f',    'word': 'radians(',
    \                   'abbr': 'radians',
    \                   'info': "\/\/ convert from degrees to radians\n" .
    \                           "genType radians(genType degrees);" },
    \ { 'kind': 'f',    'word': 'reflect(',
    \                   'abbr': 'reflect',
    \                   'info': "\/\/ \n" .
    \                           "reflect();" },
    \ { 'kind': 'f',    'word': 'refract(',
    \                   'abbr': 'refract',
    \                   'info': "\/\/ \n" .
    \                           "refract();" },
    \ { 'kind': 'f',    'word': 'round(',
    \                   'abbr': 'round',
    \                   'info': "\/\/ return the nearest integer to x\n" .
    \                           "\/\/ rounding 0.5 is implementation dependent\n" .
    \                           "genType  round(genType  x);\n" .
    \                           "genDType round(genDType x);" },
    \ { 'kind': 'f',    'word': 'roundEven(',
    \                   'abbr': 'roundEven',
    \                   'info': "\/\/ find the nearest even integer to x\n" .
    \                           "genType  roundEven(genType  x);\n" .
    \                           "genDType roundEven(genDType x);" },
    \ { 'kind': 'f',    'word': 'sign(',
    \                   'abbr': 'sign',
    \                   'info': "\/\/ determine the sign of of x\n" .
    \                           "\/\/ returns -1 if x < 0; 0 if x == 0; 1 if x > 0\n";
    \                           "genType  sign(genType  x);\n" .
    \                           "genDType sign(genDType x);\n" .
    \                           "genIType sign(genIType x);" },
    \ { 'kind': 'f',    'word': 'sin(',
    \                   'abbr': 'sin',
    \                   'info': "\/\/ return the sine of the given angle\n" .
    \                           "\/\/ angle must be in radians\n" .
    \                           "genType sin(genType angle);" },
    \ { 'kind': 'f',    'word': 'sinh(',
    \                   'abbr': 'sinh',
    \                   'info': "\/\/ return the hyperbolic sine of x\n" .
    \                           "\/\/ the formula is (e^x - e^-x) / 2\n" .
    \                           "genType sinh(genType x);" },
    \ { 'kind': 'f',    'word': 'smoothstep(',
    \                   'abbr': 'smoothstep',
    \                   'info': "\/\/ perform a Hermite interpolation between edge0 and edge1\n" .
    \                           "\/\/ this is equivalent to:\n" .
    \                           "\/\/     genType t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);\n" .
    \                           "\/\/     return t * t * (3.0 - 2.0 * t);\n" .
    \                           "\/\/ the result is undefined if edge0 >= edge1\n" .
    \                           "genType  smoothstep(genType  edge0, genType  edge1, genType  x);\n" .
    \                           "genType  smoothstep(float    edge0, float    edge1, genType  x);\n" .
    \                           "genDType smoothstep(genDType edge0, genDType edge1, genDType x);\n" .
    \                           "genDType smoothstep(double   edge0, double   edge1, genDType x);\n" },
    \ { 'kind': 'f',    'word': 'sqrt(',
    \                   'abbr': 'sqrt',
    \                   'info': "\/\/ return the square root of x\n" .
    \                           "\/\/ the result is undefined if x < 0\n" .
    \                           "genType  sqrt(genType  x);\n" .
    \                           "genDType sqrt(genDType x);" },
    \ { 'kind': 'f',    'word': 'step(',
    \                   'abbr': 'step',
    \                   'info': "\/\/ generate a step function by comparing edge to x\n" .
    \                           "\/\/ for each component c, this is x.c < edge.c ? 0 : 1\n" .
    \                           "genType  step(genType  edge, genType  x);\n" .
    \                           "genType  step(float    edge, genType  x);\n" .
    \                           "genDType step(genDType edge, genDType x);\n" .
    \                           "genDType step(double   edge, genDType x);" },
    \ { 'kind': 'f',    'word': 'tan(',
    \                   'abbr': 'tan',
    \                   'info': "\/\/ return the tangent of the given angle\n" .
    \                           "\/\/ angle must be in radians\n" .
    \                           "genType tan(genType angle);" },
    \ { 'kind': 'f',    'word': 'tanh(',
    \                   'abbr': 'tanh',
    \                   'info': "\/\/ return the hyperbolic tangent of x\n" .
    \                           "\/\/ the formula is sinh(x) / cosh(x)\n" .
    \                           "genType tanh(genType x);" },
    \ { 'kind': 'f',    'word': 'texelFetch(',
    \                   'abbr': 'texelFetch',
    \                   'info': "\/\/ \n" .
    \                           "texelFetch();" },
    \ { 'kind': 'f',    'word': 'texelFetchOffset(',
    \                   'abbr': 'texelFetchOffset',
    \                   'info': "\/\/ \n" .
    \                           "texelFetchOffset();" },
    \ { 'kind': 'f',    'word': 'texture(',
    \                   'abbr': 'texture',
    \                   'info': "\/\/ \n" .
    \                           "texture();" },
    \ { 'kind': 'f',    'word': 'textureGather(',
    \                   'abbr': 'textureGather',
    \                   'info': "\/\/ \n" .
    \                           "textureGather();" },
    \ { 'kind': 'f',    'word': 'textureGatherOffset(',
    \                   'abbr': 'textureGatherOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureGatherOffset();" },
    \ { 'kind': 'f',    'word': 'textureGatherOffsets(',
    \                   'abbr': 'textureGatherOffsets',
    \                   'info': "\/\/ \n" .
    \                           "textureGatherOffsets();" },
    \ { 'kind': 'f',    'word': 'textureGrad(',
    \                   'abbr': 'textureGrad',
    \                   'info': "\/\/ \n" .
    \                           "textureGrad();" },
    \ { 'kind': 'f',    'word': 'textureGradOffset(',
    \                   'abbr': 'textureGradOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureGradOffset();" },
    \ { 'kind': 'f',    'word': 'textureLod(',
    \                   'abbr': 'textureLod',
    \                   'info': "\/\/ \n" .
    \                           "textureLod();" },
    \ { 'kind': 'f',    'word': 'textureLodOffset(',
    \                   'abbr': 'textureLodOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureLodOffset();" },
    \ { 'kind': 'f',    'word': 'textureOffset(',
    \                   'abbr': 'textureOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureOffset();" },
    \ { 'kind': 'f',    'word': 'textureProj(',
    \                   'abbr': 'textureProj',
    \                   'info': "\/\/ \n" .
    \                           "textureProj();" },
    \ { 'kind': 'f',    'word': 'textureProjGrad(',
    \                   'abbr': 'textureProjGrad',
    \                   'info': "\/\/ \n" .
    \                           "textureProjGrad();" },
    \ { 'kind': 'f',    'word': 'textureProjGradOffset(',
    \                   'abbr': 'textureProjGradOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureProjGradOffset();" },
    \ { 'kind': 'f',    'word': 'textureProjLod(',
    \                   'abbr': 'textureProjLod',
    \                   'info': "\/\/ \n" .
    \                           "textureProjLod();" },
    \ { 'kind': 'f',    'word': 'textureProjLodOffset(',
    \                   'abbr': 'textureProjLodOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureProjLodOffset();" },
    \ { 'kind': 'f',    'word': 'textureProjOffset(',
    \                   'abbr': 'textureProjOffset',
    \                   'info': "\/\/ \n" .
    \                           "textureProjOffset();" },
    \ { 'kind': 'f',    'word': 'textureQueryLod(',
    \                   'abbr': 'textureQueryLod',
    \                   'info': "\/\/ \n" .
    \                           "textureQueryLod();" },
    \ { 'kind': 'f',    'word': 'textureQueryLevels(',
    \                   'abbr': 'textureQueryLevels',
    \                   'info': "\/\/ \n" .
    \                           "textureQueryLevels();" },
    \ { 'kind': 'f',    'word': 'textureSamples(',
    \                   'abbr': 'textureSamples',
    \                   'info': "\/\/ \n" .
    \                           "textureSamples();" },
    \ { 'kind': 'f',    'word': 'textureSize(',
    \                   'abbr': 'textureSize',
    \                   'info': "\/\/ \n" .
    \                           "textureSize();" },
    \ { 'kind': 'f',    'word': 'transpose(',
    \                   'abbr': 'transpose',
    \                   'info': "\/\/ \n" .
    \                           "transpose();" },
    \ { 'kind': 'f',    'word': 'trunc(',
    \                   'abbr': 'trunc',
    \                   'info': "\/\/ return the nearest integer i, such that abs(i) <= abs(x)\n" .
    \                           "genType  trunc(genType  x);" .
    \                           "genDType trunc(genDType x);" },
    \ { 'kind': 'f',    'word': 'uaddCarry(',
    \                   'abbr': 'uaddCarry',
    \                   'info': "\/\/ \n" .
    \                           "uaddCarry();" },
    \ { 'kind': 'f',    'word': 'uintBitsToFloat(',
    \                   'abbr': 'uintBitsToFloat',
    \                   'info': "\/\/ return a floating point value using the supplied unsigned integer as the encoding\n" .
    \                           "genType uintBitsToFloat(genUType x);" },
    \ { 'kind': 'f',    'word': 'umulExtended(',
    \                   'abbr': 'umulExtended',
    \                   'info': "\/\/ \n" .
    \                           "umulExtended();" },
    \ { 'kind': 'f',    'word': 'unpackDouble2x32(',
    \                   'abbr': 'unpackDouble2x32',
    \                   'info': "\/\/ \n" .
    \                           "unpackDouble2x32();" },
    \ { 'kind': 'f',    'word': 'unpackHalf2x16(',
    \                   'abbr': 'unpackHalf2x16',
    \                   'info': "\/\/ \n" .
    \                           "unpackHalf2x16();" },
    \ { 'kind': 'f',    'word': 'unpackSnorm2x16(',
    \                   'abbr': 'unpackSnorm2x16',
    \                   'info': "\/\/ \n" .
    \                           "unpackSnorm2x16();" },
    \ { 'kind': 'f',    'word': 'unpackSnorm4x8(',
    \                   'abbr': 'unpackSnorm4x8',
    \                   'info': "\/\/ \n" .
    \                           "unpackSnorm4x8();" },
    \ { 'kind': 'f',    'word': 'unpackSnorm2x16(',
    \                   'abbr': 'unpackSnorm2x16',
    \                   'info': "\/\/ unpack floating point values from an unsigned integer\n" .
    \                           "\/\/ p is the integer containing the packed floating point data\n" .
    \                           "\/\/ the first floating point value, f1, is extracted from the 16 LSBs\n" .
    \                           "\/\/ the second floating point value, f2, is extracted from the 16 MSBs\n" .
    \                           "\/\/ return clampe(vec2(f1, f2) / 65536.0, -1.0, 1.0);\n" .
    \                           "vec2 unpackSnorm2x16(uint p);" },
    \ { 'kind': 'f',    'word': 'unpackSnorm4x8(',
    \                   'abbr': 'unpackSnorm4x8',
    \                   'info': "\/\/ unpack floating point values from an unsigned integer\n" .
    \                           "\/\/ p is the integer containing the packed floating point data\n" .
    \                           "\/\/ the first floating point value, f1, is extracted from the 8 LSBs\n" .
    \                           "\/\/ the fourth floating point value, f4, is extracted from the 8 MSBs\n" .
    \                           "\/\/ the second & third values, f2 & f3, are extracted from the corresponding bits\n" .
    \                           "\/\/ return clamp(vec4(f1, f2, f3, f4) / 65536.0, -1.0, 1.0);\n" .
    \                           "vec4 unpackSnorm4x8(uint p);" },
    \ { 'kind': 'f',    'word': 'unpackUnorm2x16(',
    \                   'abbr': 'unpackUnorm2x16',
    \                   'info': "\/\/ unpack floating point values from an unsigned integer\n" .
    \                           "\/\/ p is the integer containing the packed floating point data\n" .
    \                           "\/\/ the first floating point value, f1, is extracted from the 16 LSBs\n" .
    \                           "\/\/ the second floating point value, f2, is extracted from the 16 MSBs\n" .
    \                           "\/\/ return vec2(f1, f2) / 65536.0;\n" .
    \                           "vec2 unpackUnorm2x16(uint p);" },
    \ { 'kind': 'f',    'word': 'unpackUnorm4x8(',
    \                   'abbr': 'unpackUnorm4x8',
    \                   'info': "\/\/ unpack floating point values from an unsigned integer\n" .
    \                           "\/\/ p is the integer containing the packed floating point data\n" .
    \                           "\/\/ the first floating point value, f1, is extracted from the 8 LSBs\n" .
    \                           "\/\/ the fourth floating point value, f4, is extracted from the 8 MSBs\n" .
    \                           "\/\/ the second & third values, f2 & f3, are extracted from the corresponding bits\n" .
    \                           "\/\/ return vec4(f1, f2, f3, f4) / 65536.0;\n" .
    \                           "vec4 unpackUnorm4x8(uint p);" },
    \ { 'kind': 'f',    'word': 'usubBorrow(',
    \                   'abbr': 'usubBorrow',
    \                   'info': "\/\/ \n" .
    \                           "usubBorrow();" },
    \ { 'kind': 'f',    'word': 'contained(',
    \                   'abbr': 'contained',
    \                   'info': "\/\/ \n" .
    \                           "contained();" },
"}}}

"au! CursorHold *.[ch] nested call PreviewWord()
function! glslcomplete#preview_highlight()
"  if &previewwindow            " don't do this in the preview window
"    return
"  endif
"  let w = expand("<cword>")        " get the word under cursor
"  if w =~ '\a'         " if the word contains a letter
"
    " Delete any existing highlight before showing another tag
    "silent! wincmd P           " jump to preview window
    wincmd P
    if &previewwindow           " if we really get there...
        set filetype=glsl
"      match none           " delete existing highlight
      wincmd p          " back to old window
    endif
"
"    " Try displaying a matching tag for the word under the cursor
"    try
"       exe "ptag " . w
"    catch
"      return
"    endtry
"
"    silent! wincmd P           " jump to preview window
"    if &previewwindow      " if we really get there...
"    if has("folding")
"      silent! .foldopen        " don't want a closed fold
"    endif
"    call search("$", "b")      " to end of previous line
"    let w = substitute(w, '\\', '\\\\', "")
"    call search('\<\V' . w . '\>') " position cursor on match
"    " Add a match highlight to the word at this position
"      hi previewWord term=bold ctermbg=green guibg=green
"    exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
"      wincmd p         " back to old window
"    endif
"  endif
endfunction


" This function is used for the 'omnifunc' option.
function! glslcomplete#Complete(findstart, base)
    if a:findstart
        " Locate the start of the item
        let line = getline('.')
        let start = col('.') - 1
        while (0 < start) && (line[start - 1] =~'\w')
            let start -= 1
        endwhile
        let g:glsl_cache = start
        return start
    endif

    " Return list of matches.
    " Don't do anything for an empty base, would result in all the tags in the
    " tags file.
    if a:base == ''
        return []
    endif

    let base_pattern = '^' . a:base
    let matches = []
    for builtin in s:glsl_builtins
        if builtin['abbr'] =~ base_pattern
            call add(matches, builtin)
        endif
    endfor

    return matches
endfunc

let &cpo = s:cpo_save
unlet s:cpo_save

