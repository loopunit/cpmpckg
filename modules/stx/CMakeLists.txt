cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  stx_cpm
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
    NAME stx
	GITHUB_REPOSITORY lamarrr/STX
	GIT_TAG a984c0fe9610548e880e775e279403bd8941d2eb
    DOWNLOAD_ONLY true)

configure_file(patch_CMakeLists.txt ${stx_SOURCE_DIR}/CMakeLists.txt COPYONLY)

if (NOT ${CPM_FOR_INSTALL})
    message(FATAL_ERROR "CPM_FOR_INSTALL should be true")
endif()

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/stx)
set(BUILD_TESTING Off)

add_subdirectory(${stx_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/stx_cpm_install)

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(stx PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(stx PROPERTIES COMPILE_PDB_NAME stx COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(stx PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(stx PROPERTIES COMPILE_PDB_NAME stx COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()
