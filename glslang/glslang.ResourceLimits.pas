unit glslang.ResourceLimits;

interface //#################################################################### ■

//
//Copyright (C) 2002-2005  3Dlabs Inc. Ltd.
//Copyright (C) 2013 LunarG, Inc.
//
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions
//are met:
//
//    Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
//    Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimer in the documentation and/or other materials provided
//    with the distribution.
//
//    Neither the name of 3Dlabs Inc. Ltd. nor the names of its
//    contributors may be used to endorse or promote products derived
//    from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
//COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
//ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//POSSIBILITY OF SUCH DAMAGE.
//

uses LUX.Code.C;

type TLimits = record
       nonInductiveForLoops                 :T_bool;
       whileLoops                           :T_bool;
       doWhileLoops                         :T_bool;
       generalUniformIndexing               :T_bool;
       generalAttributeMatrixVectorIndexing :T_bool;
       generalVaryingIndexing               :T_bool;
       generalSamplerIndexing               :T_bool;
       generalVariableIndexing              :T_bool;
       generalConstantMatrixVectorIndexing  :T_bool;
     end;

type PBuiltInResource = ^TBuiltInResource;
     TBuiltInResource = record
       maxLights                                 :T_int;
       maxClipPlanes                             :T_int;
       maxTextureUnits                           :T_int;
       maxTextureCoords                          :T_int;
       maxVertexAttribs                          :T_int;
       maxVertexUniformComponents                :T_int;
       maxVaryingFloats                          :T_int;
       maxVertexTextureImageUnits                :T_int;
       maxCombinedTextureImageUnits              :T_int;
       maxTextureImageUnits                      :T_int;
       maxFragmentUniformComponents              :T_int;
       maxDrawBuffers                            :T_int;
       maxVertexUniformVectors                   :T_int;
       maxVaryingVectors                         :T_int;
       maxFragmentUniformVectors                 :T_int;
       maxVertexOutputVectors                    :T_int;
       maxFragmentInputVectors                   :T_int;
       minProgramTexelOffset                     :T_int;
       maxProgramTexelOffset                     :T_int;
       maxClipDistances                          :T_int;
       maxComputeWorkGroupCountX                 :T_int;
       maxComputeWorkGroupCountY                 :T_int;
       maxComputeWorkGroupCountZ                 :T_int;
       maxComputeWorkGroupSizeX                  :T_int;
       maxComputeWorkGroupSizeY                  :T_int;
       maxComputeWorkGroupSizeZ                  :T_int;
       maxComputeUniformComponents               :T_int;
       maxComputeTextureImageUnits               :T_int;
       maxComputeImageUniforms                   :T_int;
       maxComputeAtomicCounters                  :T_int;
       maxComputeAtomicCounterBuffers            :T_int;
       maxVaryingComponents                      :T_int;
       maxVertexOutputComponents                 :T_int;
       maxGeometryInputComponents                :T_int;
       maxGeometryOutputComponents               :T_int;
       maxFragmentInputComponents                :T_int;
       maxImageUnits                             :T_int;
       maxCombinedImageUnitsAndFragmentOutputs   :T_int;
       maxCombinedShaderOutputResources          :T_int;
       maxImageSamples                           :T_int;
       maxVertexImageUniforms                    :T_int;
       maxTessControlImageUniforms               :T_int;
       maxTessEvaluationImageUniforms            :T_int;
       maxGeometryImageUniforms                  :T_int;
       maxFragmentImageUniforms                  :T_int;
       maxCombinedImageUniforms                  :T_int;
       maxGeometryTextureImageUnits              :T_int;
       maxGeometryOutputVertices                 :T_int;
       maxGeometryTotalOutputComponents          :T_int;
       maxGeometryUniformComponents              :T_int;
       maxGeometryVaryingComponents              :T_int;
       maxTessControlInputComponents             :T_int;
       maxTessControlOutputComponents            :T_int;
       maxTessControlTextureImageUnits           :T_int;
       maxTessControlUniformComponents           :T_int;
       maxTessControlTotalOutputComponents       :T_int;
       maxTessEvaluationInputComponents          :T_int;
       maxTessEvaluationOutputComponents         :T_int;
       maxTessEvaluationTextureImageUnits        :T_int;
       maxTessEvaluationUniformComponents        :T_int;
       maxTessPatchComponents                    :T_int;
       maxPatchVertices                          :T_int;
       maxTessGenLevel                           :T_int;
       maxViewports                              :T_int;
       maxVertexAtomicCounters                   :T_int;
       maxTessControlAtomicCounters              :T_int;
       maxTessEvaluationAtomicCounters           :T_int;
       maxGeometryAtomicCounters                 :T_int;
       maxFragmentAtomicCounters                 :T_int;
       maxCombinedAtomicCounters                 :T_int;
       maxAtomicCounterBindings                  :T_int;
       maxVertexAtomicCounterBuffers             :T_int;
       maxTessControlAtomicCounterBuffers        :T_int;
       maxTessEvaluationAtomicCounterBuffers     :T_int;
       maxGeometryAtomicCounterBuffers           :T_int;
       maxFragmentAtomicCounterBuffers           :T_int;
       maxCombinedAtomicCounterBuffers           :T_int;
       maxAtomicCounterBufferSize                :T_int;
       maxTransformFeedbackBuffers               :T_int;
       maxTransformFeedbackInterleavedComponents :T_int;
       maxCullDistances                          :T_int;
       maxCombinedClipAndCullDistances           :T_int;
       maxSamples                                :T_int;

       limits                                    :TLimits;
     end;

implementation //############################################################### ■

end. //######################################################################### ■
