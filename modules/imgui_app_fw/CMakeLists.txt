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
	GIT_TAG 7e581f6342b411eef1824f7a0ee278290a076fd5
	OPTIONS
		"CPM_DEV_ROOT:PATH=${CPM_DEV_ROOT}"
		"CPM_SCRIPTS:PATH=${CPM_SCRIPTS}"
		"cpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}"
		"CPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}"
		"CPM_INSTALL_CACHE:PATH=${CPM_INSTALL_CACHE}"
		"CPM_INSTALL_BUILD_CACHE:PATH=${CPM_INSTALL_BUILD_CACHE}"
		"CMAKE_BUILD_TYPE:STRING=${CPM_BUILD_TYPE}"
		"CMAKE_INSTALL_PREFIX:PATH=${CPM_INSTALL_CACHE}/imgui_app_fw")

if(NOT ${imgui_app_fw_ADDED})
	message( FATAL_ERROR "Could not find imgui_app_fw" )
endif()		