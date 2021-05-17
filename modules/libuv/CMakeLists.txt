cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  libuv_cpm
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
    NAME libuv
	GITHUB_REPOSITORY libuv/libuv
	GIT_TAG ac5b21a2c900a3fa33cb49acf637039d7c8af28e
	OPTIONS
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
    "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
    "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/libuv")
	
	cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
