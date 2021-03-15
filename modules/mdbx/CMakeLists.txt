cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  mdbx_cpm
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
    NAME mdbx
    GITHUB_REPOSITORY erthink/libmdbx
    GIT_TAG adc720816970335d6b7ef85e8a08ddcb336f0dd0
    DOWNLOAD_ONLY true)

if(NOT ${mdbx_ADDED})
	message( FATAL_ERROR "Could not find mdbx" )
endif()

configure_file(patch_CMakeLists.txt ${mdbx_SOURCE_DIR}/CMakeLists.txt COPYONLY)
configure_file(patch_mdbx.h++ ${mdbx_SOURCE_DIR}/mdbx.h++ COPYONLY)

if (NOT ${CPM_FOR_INSTALL})
    message(FATAL_ERROR "CPM_FOR_INSTALL should be true")
endif()

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/mdbx)
set(MDBX_BUILD_TOOLS Off)
set(BUILD_TESTING Off)

add_subdirectory(${mdbx_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/mdbx_cpm_install)

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(mdbx PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(mdbx PROPERTIES COMPILE_PDB_NAME mdbx COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(mdbx PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(mdbx PROPERTIES COMPILE_PDB_NAME mdbx COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()
