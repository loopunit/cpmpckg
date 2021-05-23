cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  taskflow_cpm
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
    NAME taskflow
	GITHUB_REPOSITORY taskflow/taskflow
	GIT_TAG 82c0d7048819efd949b12d53176765218f3495ef
	OPTIONS
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
		"CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
		"CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/taskflow"
		"TF_BUILD_TESTS Off"
		"TF_BUILD_EXAMPLES Off")
	
	cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
