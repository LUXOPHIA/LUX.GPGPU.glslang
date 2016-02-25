unit glslang.ShaderLang;

interface //#################################################################### ■

//
//Copyright (C) 2002-2005  3Dlabs Inc. Ltd.
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

uses glslang.ResourceLimits, glslang.Versions,
     LUX.Code.C;

const DLLNAME = 'glslang.dll';

//
// This is the platform independent interface between an OGL driver
// and the shading language compiler/linker.
//

//
// Driver must call this first, once, before doing any other
// compiler/linker operations.
//
// (Call once per process, not once per thread.)
//
function ShInitialize :T_int; cdecl; external DLLNAME;

//
// Driver should call this at process shutdown.
//
function ShFinalize :T_int; cdecl; external DLLNAME;

//
// Types of languages the compiler can consume.
//
type T_EShLanguage = (
    EShLangVertex,
    EShLangTessControl,
    EShLangTessEvaluation,
    EShLangGeometry,
    EShLangFragment,
    EShLangCompute,
    EShLangCount
);

type T_EShLanguageMask = (
    EShLangVertexMask         = 1 shl EShLangVertex,
    EShLangTessControlMask    = 1 shl EShLangTessControl,
    EShLangTessEvaluationMask = 1 shl EShLangTessEvaluation,
    EShLangGeometryMask       = 1 shl EShLangGeometry,
    EShLangFragmentMask       = 1 shl EShLangFragment,
    EShLangComputeMask        = 1 shl EShLangCompute
);

function StageName(EShLanguage) :P_char; cdecl; external DLLNAME;

//
// Types of output the linker will create.
//
type T_EShExecutable = (
    EShExVertexFragment,
    EShExFragment
);

//
// Optimization level for the compiler.
//
type T_EShOptimizationLevel = (
    EShOptNoGeneration,
    EShOptNone,
    EShOptSimple,        // Optimizations that can be done quickly
    EShOptFull           // Optimizations that will take more time
);

//
// Message choices for what errors and warnings are given.
//
type T_EShMessages = (
    EShMsgDefault          = 0,        // default is to give all required errors and extra warnings
    EShMsgRelaxedErrors    = 1 shl 0,  // be liberal in accepting input
    EShMsgSuppressWarnings = 1 shl 1,  // suppress all warnings, except those required by the specification
    EShMsgAST              = 1 shl 2,  // print the AST intermediate representation
    EShMsgSpvRules         = 1 shl 3,  // issue messages for SPIR-V generation
    EShMsgVulkanRules      = 1 shl 4,  // issue messages for Vulkan-requirements of GLSL for SPIR-V
    EShMsgOnlyPreprocessor = 1 shl 5   // only print out errors produced by the preprocessor
);

//
// Build a table for bindings.  This can be used for locating
// attributes, uniforms, globals, etc., as needed.
//
type P_ShBinding = ^T_ShBinding;
     T_ShBinding = record
       name    :P_char;
       binding :T_int;
     end;

type PP_ShBindingTable = ^P_ShBindingTable;
     P_ShBindingTable = ^T_ShBindingTable;
     T_ShBindingTable = record
       numBindings :T_int;
       bindings    :P_ShBinding;  // array of bindings
     end;

//
// ShHandle held by but opaque to the driver.  It is allocated,
// managed, and de-allocated by the compiler/linker. It's contents 
// are defined by and used by the compiler and linker.  For example,
// symbol table information and object code passed from the compiler 
// to the linker can be stored where ShHandle points.
//
// If handle creation fails, 0 will be returned.
//
type T_ShHandle = P_void;

//
// Driver calls these to create and destroy compiler/linker
// objects.
//
function ShConstructCompiler( const EShLanguage_:T_EShLanguage; debugOptions:T_int ) :T_ShHandle; cdecl; external DLLNAME;  // one per shader
function ShConstructLinker( const EShExecutable_:T_EShExecutable; debugOptions:T_int ) :T_ShHandle; cdecl; external DLLNAME;  // one per shader pair
function ShConstructUniformMap :T_ShHandle; cdecl; external DLLNAME;  // one per uniform namespace (currently entire program object)
procedure ShDestruct( ShHandle_:T_ShHandle ); cdecl; external DLLNAME;

//
// The return value of ShCompile is boolean, non-zero indicating
// success.
//
// The info-log should be written by ShCompile into 
// ShHandle, so it can answer future queries.
//
function ShCompile(
    const ShHandle_             :T_ShHandle;
    const shaderStrings         :array of P_char;
    const numStrings            :T_int;
    const lengths               :P_int;
    const EShOptimizationLevel_ :T_EShOptimizationLevel;
    const resources             :PBuiltInResource;
          debugOptions          :T_int;
          defaultVersion        :T_int = 110;                   // use 100 for ES environment, overridden by #version in shader
          forwardCompatible     :T_bool = false;                // give errors for use of deprecated features
          messages              :T_EShMessages = EShMsgDefault  // warnings and errors
                                                              ) :T_int; cdecl; external DLLNAME;

function ShLink(
    const ShHandle_            :T_ShHandle;            // linker object
    const h                    :array of T_ShHandle;   // compiler objects to link together
    const numHandles           :T_int;
          uniformMap           :T_ShHandle;            // updated with new uniforms
          uniformsAccessed     :array of P_short_int;  // returned with indexes of uniforms accessed
          numUniformsAccessed  :P_int                ) :T_int; cdecl; external DLLNAME;

function ShLinkExt(
    const ShHandle_  :T_ShHandle;           // linker object
    const h          :array of T_ShHandle;  // compiler objects to link together
    const numHandles :T_int               ) :T_int; cdecl; external DLLNAME;

//
// ShSetEncrpytionMethod is a place-holder for specifying
// how source code is encrypted.
//
procedure ShSetEncryptionMethod( _ShHandle:T_ShHandle ); cdecl; external DLLNAME;

//
// All the following return 0 if the information is not
// available in the object passed down, or the object is bad.
//
function ShGetInfoLog( const ShHandle_:T_ShHandle ) :P_char; cdecl; external DLLNAME;
function ShGetExecutable( const ShHandle_:T_ShHandle ) :P_void; cdecl; external DLLNAME;
function ShSetVirtualAttributeBindings( const ShHandle_:T_ShHandle; const ShBindingTable_:P_ShBindingTable ) :T_int; cdecl; external DLLNAME;   // to detect user aliasing
function ShSetFixedAttributeBindings( const ShHandle_:T_ShHandle; const ShBindingTable_:P_ShBindingTable ) :T_int; cdecl; external DLLNAME;     // to force any physical mappings
function ShGetPhysicalAttributeBindings( const ShHandle_:T_ShHandle; const ShBindingTable_:PP_ShBindingTable ) :T_int; cdecl; external DLLNAME; // for all attributes
//
// Tell the linker to never assign a vertex attribute to this list of physical attributes
//
function ShExcludeAttributes( const ShHandle_:T_ShHandle; attributes:P_int; count:T_int ) :T_int; cdecl; external DLLNAME;

//
// Returns the location ID of the named uniform.
// Returns -1 if error.
//
function ShGetUniformLocation( const uniformMap:T_ShHandle; const name:P_char ) :T_int; cdecl; external DLLNAME;

implementation //############################################################### ■

end. //######################################################################### ■
