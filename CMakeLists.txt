cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cpmpckg
  VERSION 0.0.0
)

include(cmake/add_cpm_module.cmake)

option(CMP_USE_spirv_headers, "", false);
include(modules/spirv_headers.cmake)

option(CMP_USE_spirv_tools, "", false);
include(modules/spirv_tools.cmake)

option(CMP_USE_spirv_cross, "", false);
include(modules/spirv_cross.cmake)

option(CMP_USE_python, "", false);
include(modules/python.cmake)

option(CMP_USE_glslang, "", false);
include(modules/glslang.cmake)

option(CMP_USE_libmdbx, "", false);
include(modules/libmdbx.cmake)

option(CMP_USE_basis_universal, "", false);
include(modules/basis_universal.cmake)

option(CMP_USE_glfw, "", false);
include(modules/glfw.cmake)

option(CMP_USE_imgui, "", false);
include(modules/imgui.cmake)

option(CMP_USE_framegraph, "", false);
include(modules/framegraph.cmake)
