cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  mu_stdlib
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
    NAME mu_stdlib
    GITHUB_REPOSITORY loopunit/mu_stdlib.cpmpckg
	GIT_TAG 1569c8374589834c2dda006d7153b2f5d365be99
	OPTIONS
		"IMGUI_BUILD_APP_FW True"
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
        "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/mu_stdlib")

if(NOT ${mu_stdlib_ADDED})
	message( FATAL_ERROR "Could not find mu_stdlib" )
endif()		