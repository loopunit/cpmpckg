cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  boostorg_leaf_cpm
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
    NAME boostorg_leaf
	GITHUB_REPOSITORY boostorg/leaf
	GIT_TAG 0d51eb85ece592c154a8a1515488b50f284eeae5
	OPTIONS
	OPTIONS
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_TOOLCHAIN_CACHE ${CPM_TOOLCHAIN_CACHE}"
		"CPM_RUNTIME_CACHE ${CPM_RUNTIME_CACHE}"
		"CPM_RUNTIME_BUILD_CACHE ${CPM_RUNTIME_BUILD_CACHE}"
        "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
        "CMAKE_INSTALL_PREFIX ${CPM_RUNTIME_CACHE}/boostorg_leaf")
