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
