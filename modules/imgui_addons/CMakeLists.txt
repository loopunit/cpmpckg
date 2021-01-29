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
	GIT_TAG 6eb1e5096a7106c87ff91c23669b46e82a8a0d1c
	OPTIONS
		"IMGUI_BUILD_APP_FW True"
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_TOOLCHAIN_CACHE ${CPM_TOOLCHAIN_CACHE}"
		"CPM_RUNTIME_CACHE ${CPM_RUNTIME_CACHE}"
		"CPM_RUNTIME_BUILD_CACHE ${CPM_RUNTIME_BUILD_CACHE}"
        "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
        "CMAKE_INSTALL_PREFIX ${CPM_RUNTIME_CACHE}/imgui_addons")

if(NOT ${imgui_addons_ADDED})
	message( FATAL_ERROR "Could not find imgui_addons" )
endif()		