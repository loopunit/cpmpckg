cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  imgui_addons
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
    NAME imgui_addons
    GITHUB_REPOSITORY loopunit/imgui_addons.cpmpckg
	GIT_TAG 98a473b9dec4882c243fe3df5d0b2da56a83e926
	OPTIONS
		"IMGUI_BUILD_APP_FW True"
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
        "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/imgui_addons")

if(NOT ${imgui_addons_ADDED})
	message( FATAL_ERROR "Could not find imgui_addons" )
endif()		