cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  llfio_cpm
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
    NAME llfio
    GITHUB_REPOSITORY ned14/llfio
	GIT_TAG a93b8521afb5d858f423de7accdc6d9d4504e7cb
    DOWNLOAD_ONLY true)

if(NOT ${llfio_ADDED})
	message( FATAL_ERROR "Could not find llfio" )
endif()

configure_file(patch_CMakeLists.txt ${llfio_SOURCE_DIR}/CMakeLists.txt COPYONLY)

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/llfio)
#set(PROJECT_IS_DEPENDENCY True)
#set(BASIS_BUILD_LIBRARY True)
#set(BUILD_TESTING Off)

add_subdirectory(${llfio_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/llfio_cpm_install)

#if(MSVC)
#  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
#    set_target_properties(basis PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
#    set_target_properties(basis PROPERTIES COMPILE_PDB_NAME basis COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
#  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
#    set_target_properties(basis PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
#    set_target_properties(basis PROPERTIES COMPILE_PDB_NAME basis COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
#  endif()
#endif()
