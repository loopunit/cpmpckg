cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  basis_universal_cpm
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
    NAME basis_universal
    GITHUB_REPOSITORY BinomialLLC/basis_universal
	GIT_TAG ef70ddd7c92222a6369f8b296af42b8f9699708b
    DOWNLOAD_ONLY true)

if(NOT ${basis_universal_ADDED})
	message( FATAL_ERROR "Could not find basis_universal" )
endif()

configure_file(patch_CMakeLists.txt ${basis_universal_SOURCE_DIR}/CMakeLists.txt COPYONLY)
configure_file(patch_basisu.h ${basis_universal_SOURCE_DIR}/transcoder/basisu.h COPYONLY)

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/basis_universal)
set(BASIS_BUILD_TOOL False)
set(BASIS_BUILD_LIBRARY True)
set(BUILD_TESTING Off)

add_subdirectory(${basis_universal_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/basis_universal_cpm_install)