cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  imgui_app
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
    NAME imgui_app
    GITHUB_REPOSITORY loopunit/imgui_app.cpmpckg
	GIT_TAG e392a4016789a8ac08d192e88e3fc93012bbc03a
	OPTIONS
  "CPM_DEV_ROOT:PATH=${CPM_DEV_ROOT}"
  "CPM_SCRIPTS:PATH=${CPM_SCRIPTS}"
  "cpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}"
  "CPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}"
  "CPM_INSTALL_CACHE:PATH=${CPM_INSTALL_CACHE}"
  "CPM_INSTALL_BUILD_CACHE:PATH=${CPM_INSTALL_BUILD_CACHE}"
      "CMAKE_BUILD_TYPE:STRING=${CPM_BUILD_TYPE}"
      "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/imgui_app")

if(NOT ${imgui_app_ADDED})
	message( FATAL_ERROR "Could not find imgui_app" )
endif()		