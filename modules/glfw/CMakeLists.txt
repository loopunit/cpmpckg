cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  glfw_cpm
  VERSION 1.0
  LANGUAGES CXX)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR
   "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.")
endif()

include(ExternalProject)
include(${CPM_SCRIPTS}/CPM.cmake)

CPMAddPackage(
    NAME glfw
    GITHUB_REPOSITORY glfw/glfw
    GIT_TAG 0b9e48fa3df9c184ff1abfb2452fd1a4b696ecd8
    DOWNLOAD_ONLY true)
	
if(NOT ${glfw_ADDED})
	message( FATAL_ERROR "Could not find glfw" )
endif()

if(NOT ${CPM_FOR_INSTALL})
    message(FATAL_ERROR "CPM_FOR_INSTALL should be true")
endif()

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/glfw)
set(GLFW_BUILD_EXAMPLES Off)
set(GLFW_BUILD_TESTS Off)
set(GLFW_BUILD_DOCS Off)
set(GLFW_INSTALL On)
set(GLFW_VULKAN_STATIC Off)

add_subdirectory(${glfw_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/glfw_cpm_install)

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(glfw PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(glfw PROPERTIES COMPILE_PDB_NAME glfw3 COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(glfw PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(glfw PROPERTIES COMPILE_PDB_NAME glfw3 COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()
