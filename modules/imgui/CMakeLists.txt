cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  imgui_cpm
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
	NAME imgui
	GITHUB_REPOSITORY ocornut/imgui
	GIT_TAG ac08593b9645aee7e086b1e9b98a6a1d79d09210
	DOWNLOAD_ONLY TRUE)

if(NOT ${imgui_ADDED})
	message( FATAL_ERROR "Could not find imgui" )
endif()

configure_file(patch_CMakeLists.txt ${imgui_SOURCE_DIR}/CMakeLists.txt COPYONLY)

if (${CPM_FOR_TOOLCHAIN})
    if (${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be false")
    endif()

    set(CMAKE_INSTALL_PREFIX ${CPM_TOOLCHAIN_CACHE}/imgui)
	set(BUILD_TESTING Off)

    add_subdirectory(${imgui_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/imgui_cpm_toolchain)
else()
    if (NOT ${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be true")
    endif()
    
    set(CMAKE_INSTALL_PREFIX ${CPM_RUNTIME_CACHE}/imgui)
	set(BUILD_TESTING Off)
    
    add_subdirectory(${imgui_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/imgui_cpm_runtime)
endif()
