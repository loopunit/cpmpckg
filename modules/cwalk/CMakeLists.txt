cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cwalk_cpm
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
    NAME cwalk
	GITHUB_REPOSITORY loopunit/cwalk
	GIT_TAG f77af2d26f988172f8cafe6fbc29900515ff2986
	OPTIONS
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
    "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
    "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/cwalk")
	
	cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
