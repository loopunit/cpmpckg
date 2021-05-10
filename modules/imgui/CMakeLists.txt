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
	GIT_TAG 31290807dc169d4ee62b16f42bcb1d9a294be93b
	DOWNLOAD_ONLY TRUE)

if(NOT ${imgui_ADDED})
	message( FATAL_ERROR "Could not find imgui" )
endif()

configure_file(patch_CMakeLists.txt ${imgui_SOURCE_DIR}/CMakeLists.txt COPYONLY)

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/imgui)
set(BUILD_TESTING Off)

add_subdirectory(${imgui_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/imgui_cpm_install)

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(imgui PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(imgui PROPERTIES COMPILE_PDB_NAME imgui COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(imgui PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(imgui PROPERTIES COMPILE_PDB_NAME imgui COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()
