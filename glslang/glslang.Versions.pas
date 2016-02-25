unit glslang.Versions;

interface //#################################################################### ■

//
//Copyright (C) 2002-2005  3Dlabs Inc. Ltd.
//Copyright (C) 2012-2013 LunarG, Inc.
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

//
// Help manage multiple profiles, versions, extensions etc.
//

//
// Profiles are set up for masking operations, so queries can be done on multiple
// profiles at the same time.
//
// Don't maintain an ordinal set of enums (0,1,2,3...) to avoid all possible
// defects from mixing the two different forms.
//
type T_EProfile = (
    EBadProfile           = 0,
    ENoProfile            = 1 shl 0, // only for desktop, before profiles showed up
    ECoreProfile          = 1 shl 1,
    ECompatibilityProfile = 1 shl 2,
    EEsProfile            = 1 shl 3
);

//
// Map from profile enum to externally readable text name.
//
function ProfileName( profile:T_EProfile ) :P_char; inline;

//
// The behaviors from the GLSL "#extension extension_name : behavior"
//
type TExtensionBehavior = (
    EBhMissing = 0,
    EBhRequire,
    EBhEnable,
    EBhWarn,
    EBhDisable,
    EBhDisablePartial    // use as initial state of an extension that is only partially implemented
);

//
// Symbolic names for extensions.  Strings may be directly used when calling the
// functions, but better to have the compiler do spelling checks.
//
const E_GL_OES_texture_3D                   :P_char = 'GL_OES_texture_3D';
const E_GL_OES_standard_derivatives         :P_char = 'GL_OES_standard_derivatives';
const E_GL_EXT_frag_depth                   :P_char = 'GL_EXT_frag_depth';
const E_GL_OES_EGL_image_external           :P_char = 'GL_OES_EGL_image_external';
const E_GL_EXT_shader_texture_lod           :P_char = 'GL_EXT_shader_texture_lod';

const E_GL_ARB_texture_rectangle            :P_char = 'GL_ARB_texture_rectangle';
const E_GL_3DL_array_objects                :P_char = 'GL_3DL_array_objects';
const E_GL_ARB_shading_language_420pack     :P_char = 'GL_ARB_shading_language_420pack';
const E_GL_ARB_texture_gather               :P_char = 'GL_ARB_texture_gather';
const E_GL_ARB_gpu_shader5                  :P_char = 'GL_ARB_gpu_shader5';
const E_GL_ARB_separate_shader_objects      :P_char = 'GL_ARB_separate_shader_objects';
const E_GL_ARB_compute_shader               :P_char = 'GL_ARB_compute_shader';
const E_GL_ARB_tessellation_shader          :P_char = 'GL_ARB_tessellation_shader';
const E_GL_ARB_enhanced_layouts             :P_char = 'GL_ARB_enhanced_layouts';
const E_GL_ARB_texture_cube_map_array       :P_char = 'GL_ARB_texture_cube_map_array';
const E_GL_ARB_shader_texture_lod           :P_char = 'GL_ARB_shader_texture_lod';
const E_GL_ARB_explicit_attrib_location     :P_char = 'GL_ARB_explicit_attrib_location';
const E_GL_ARB_shader_image_load_store      :P_char = 'GL_ARB_shader_image_load_store';
const E_GL_ARB_shader_atomic_counters       :P_char = 'GL_ARB_shader_atomic_counters';
const E_GL_ARB_shader_draw_parameters       :P_char = 'GL_ARB_shader_draw_parameters';
const E_GL_ARB_derivative_control           :P_char = 'GL_ARB_derivative_control';
const E_GL_ARB_shader_texture_image_samples :P_char = 'GL_ARB_shader_texture_image_samples';
const E_GL_ARB_viewport_array               :P_char = 'GL_ARB_viewport_array';
const E_GL_ARB_gl_spirv                     :P_char = 'GL_ARB_gl_spirv';
const E_GL_ARB_sparse_texture2              :P_char = 'GL_ARB_sparse_texture2';
const E_GL_ARB_sparse_texture_clamp         :P_char = 'GL_ARB_sparse_texture_clamp';
//const E_GL_ARB_cull_distance            :P_char = 'GL_ARB_cull_distance';  // present for 4.5, but need extension control over block members

// #line and #include
const E_GL_GOOGLE_cpp_style_line_directive          :P_char = 'GL_GOOGLE_cpp_style_line_directive';
const E_GL_GOOGLE_include_directive                 :P_char = 'GL_GOOGLE_include_directive';

// AEP
const E_GL_ANDROID_extension_pack_es31a             :P_char = 'GL_ANDROID_extension_pack_es31a';
const E_GL_KHR_blend_equation_advanced              :P_char = 'GL_KHR_blend_equation_advanced';
const E_GL_OES_sample_variables                     :P_char = 'GL_OES_sample_variables';
const E_GL_OES_shader_image_atomic                  :P_char = 'GL_OES_shader_image_atomic';
const E_GL_OES_shader_multisample_interpolation     :P_char = 'GL_OES_shader_multisample_interpolation';
const E_GL_OES_texture_storage_multisample_2d_array :P_char = 'GL_OES_texture_storage_multisample_2d_array';
const E_GL_EXT_geometry_shader                      :P_char = 'GL_EXT_geometry_shader';
const E_GL_EXT_geometry_point_size                  :P_char = 'GL_EXT_geometry_point_size';
const E_GL_EXT_gpu_shader5                          :P_char = 'GL_EXT_gpu_shader5';
const E_GL_EXT_primitive_bounding_box               :P_char = 'GL_EXT_primitive_bounding_box';
const E_GL_EXT_shader_io_blocks                     :P_char = 'GL_EXT_shader_io_blocks';
const E_GL_EXT_tessellation_shader                  :P_char = 'GL_EXT_tessellation_shader';
const E_GL_EXT_tessellation_point_size              :P_char = 'GL_EXT_tessellation_point_size';
const E_GL_EXT_texture_buffer                       :P_char = 'GL_EXT_texture_buffer';
const E_GL_EXT_texture_cube_map_array               :P_char = 'GL_EXT_texture_cube_map_array';

// OES matching AEP
const E_GL_OES_geometry_shader                      :P_char = 'GL_OES_geometry_shader';
const E_GL_OES_geometry_point_size                  :P_char = 'GL_OES_geometry_point_size';
const E_GL_OES_gpu_shader5                          :P_char = 'GL_OES_gpu_shader5';
const E_GL_OES_primitive_bounding_box               :P_char = 'GL_OES_primitive_bounding_box';
const E_GL_OES_shader_io_blocks                     :P_char = 'GL_OES_shader_io_blocks';
const E_GL_OES_tessellation_shader                  :P_char = 'GL_OES_tessellation_shader';
const E_GL_OES_tessellation_point_size              :P_char = 'GL_OES_tessellation_point_size';
const E_GL_OES_texture_buffer                       :P_char = 'GL_OES_texture_buffer';
const E_GL_OES_texture_cube_map_array               :P_char = 'GL_OES_texture_cube_map_array';

// Arrays of extensions for the above AEP duplications

const AEP_geometry_shader             :array of P_char = [ E_GL_EXT_geometry_shader, E_GL_OES_geometry_shader ];
const Num_AEP_geometry_shader         :T_int           = SizeOf( AEP_geometry_shader         ) div SizeOf( AEP_geometry_shader[0]         );

const AEP_geometry_point_size         :array of P_char = [ E_GL_EXT_geometry_point_size, E_GL_OES_geometry_point_size ];
const Num_AEP_geometry_point_size     :T_int           = SizeOf( AEP_geometry_point_size     ) div SizeOf( AEP_geometry_point_size[0]     );

const AEP_gpu_shader5                 :array of P_char = [ E_GL_EXT_gpu_shader5, E_GL_OES_gpu_shader5 ];
const Num_AEP_gpu_shader5             :T_int           = SizeOf( AEP_gpu_shader5             ) div SizeOf( AEP_gpu_shader5[0]             );

const AEP_primitive_bounding_box      :array of P_char = [ E_GL_EXT_primitive_bounding_box, E_GL_OES_primitive_bounding_box ];
const Num_AEP_primitive_bounding_box  :T_int           = SizeOf( AEP_primitive_bounding_box  ) div SizeOf( AEP_primitive_bounding_box[0]  );

const AEP_shader_io_blocks            :array of P_char = [ E_GL_EXT_shader_io_blocks, E_GL_OES_shader_io_blocks ];
const Num_AEP_shader_io_blocks        :T_int           = SizeOf( AEP_shader_io_blocks        ) div SizeOf( AEP_shader_io_blocks[0]        );

const AEP_tessellation_shader         :array of P_char = [ E_GL_EXT_tessellation_shader, E_GL_OES_tessellation_shader ];
const Num_AEP_tessellation_shader     :T_int           = SizeOf( AEP_tessellation_shader     ) div SizeOf( AEP_tessellation_shader[0]     );

const AEP_tessellation_point_size     :array of P_char = [ E_GL_EXT_tessellation_point_size, E_GL_OES_tessellation_point_size ];
const Num_AEP_tessellation_point_size :T_int           = SizeOf( AEP_tessellation_point_size ) div SizeOf( AEP_tessellation_point_size[0] );

const AEP_texture_buffer              :array of P_char = [ E_GL_EXT_texture_buffer, E_GL_OES_texture_buffer ];
const Num_AEP_texture_buffer          :T_int           = SizeOf( AEP_texture_buffer          ) div SizeOf(AEP_texture_buffer[0]           );

const AEP_texture_cube_map_array      :array of P_char = [ E_GL_EXT_texture_cube_map_array, E_GL_OES_texture_cube_map_array ];
const Num_AEP_texture_cube_map_array  :T_int           = SizeOf( AEP_texture_cube_map_array  ) div SizeOf( AEP_texture_cube_map_array[0]  );

implementation //############################################################### ■

function ProfileName( profile:T_EProfile ) :P_char;
begin
    case profile of
      ENoProfile           : Result := 'none';
      ECoreProfile         : Result := 'core';
      ECompatibilityProfile: Result := 'compatibility';
      EEsProfile           : Result := 'es';
    else                     Result := 'unknown profile';
    end;
end;

end. //######################################################################### ■
