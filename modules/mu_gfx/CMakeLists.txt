cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  mu_gfx
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
    NAME mu_gfx
    GITHUB_REPOSITORY loopunit/mu_gfx.cpmpckg
	GIT_TAG 85cd509407b06d4036c57145efee444cf90b81f3
	OPTIONS
		"CPM_DEV_ROOT:PATH=${CPM_DEV_ROOT}"
		"CPM_SCRIPTS:PATH=${CPM_SCRIPTS}"
		"cpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}"
		"CPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE:PATH=${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE:PATH=${CPM_INSTALL_BUILD_CACHE}"
		"CMAKE_BUILD_TYPE:STRING=${CPM_BUILD_TYPE}"
		"CMAKE_INSTALL_PREFIX:PATH=${CPM_INSTALL_CACHE}/mu_gfx")

if(NOT ${mu_gfx_ADDED})
	message( FATAL_ERROR "Could not find mu_gfx" )
endif()
