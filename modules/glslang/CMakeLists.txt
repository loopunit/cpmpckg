cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  glslang_cpm
  VERSION 1.0
  LANGUAGES CXX
)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR
   "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.")
endif()

include(ExternalProject)
include(${CPM_SCRIPTS}/CPM.cmake)

CPMAddPackage(
    NAME glslang
    GITHUB_REPOSITORY KhronosGroup/glslang
	GIT_TAG "8.13.3743"
#    GIT_TAG 6d5916d4a91eb9c3b3be377382e2c1c12443fa11
    DOWNLOAD_ONLY true)
	
if(NOT ${glslang_ADDED})
	message( FATAL_ERROR "Could not find glslang" )
endif()

configure_file(patch_CMakeLists.txt ${glslang_SOURCE_DIR}/CMakeLists.txt COPYONLY)

set(SPIRV_CROSS_ENABLE_TESTS Off)
set(SPIRV_SKIP_TESTS On)
set(BUILD_TESTING Off)
set(SPIRV_CROSS_ENABLE_TESTS Off)

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/glslang)
set(SPIRV-Headers_SOURCE_DIR ${CPM_INSTALL_CACHE}/SPIRV_Headers)
set(ENABLE_GLSLANG_BINARIES Off)

add_subdirectory(${glslang_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/glslang_cpm_install)

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(glslang PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(glslang PROPERTIES COMPILE_PDB_NAME glslang COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(glslang PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(glslang PROPERTIES COMPILE_PDB_NAME glslang COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(HLSL PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(HLSL PROPERTIES COMPILE_PDB_NAME HLSL COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(HLSL PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(HLSL PROPERTIES COMPILE_PDB_NAME HLSL COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(OGLCompiler PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(OGLCompiler PROPERTIES COMPILE_PDB_NAME OGLCompiler COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(OGLCompiler PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(OGLCompiler PROPERTIES COMPILE_PDB_NAME OGLCompiler COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(OSDependent PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(OSDependent PROPERTIES COMPILE_PDB_NAME OSDependent COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(OSDependent PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(OSDependent PROPERTIES COMPILE_PDB_NAME OSDependent COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(SPIRV PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(SPIRV PROPERTIES COMPILE_PDB_NAME SPIRV COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(SPIRV PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(SPIRV PROPERTIES COMPILE_PDB_NAME SPIRV COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set_target_properties(SPVRemapper PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
  set_target_properties(SPVRemapper PROPERTIES COMPILE_PDB_NAME SPVRemapper COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
  set_target_properties(SPVRemapper PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
  set_target_properties(SPVRemapper PROPERTIES COMPILE_PDB_NAME SPVRemapper COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
endif()
