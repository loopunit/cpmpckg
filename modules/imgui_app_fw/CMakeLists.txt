cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  imgui_app_fw
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
    NAME imgui_app_fw
    GITHUB_REPOSITORY loopunit/imgui_app_fw.cpmpckg
	GIT_TAG b8cbf4fc96fda3c0f424d7fe98ec61c583d72ac1
	OPTIONS
		"IMGUI_BUILD_APP_FW True"
		"CPM_SCRIPTS ${CPM_SCRIPTS}"
		"CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE ${CPM_INSTALL_BUILD_CACHE}"
        "CMAKE_BUILD_TYPE ${CPM_BUILD_TYPE}"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/imgui_app_fw")

if(NOT ${imgui_app_fw_ADDED})
	message( FATAL_ERROR "Could not find imgui_app_fw" )
endif()		