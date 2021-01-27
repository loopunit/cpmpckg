cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  glfw_cpm
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
    NAME glfw
    GITHUB_REPOSITORY glfw/glfw
    GIT_TAG 0b9e48fa3df9c184ff1abfb2452fd1a4b696ecd8
    DOWNLOAD_ONLY true)
	
if(NOT ${glfw_ADDED})
	message( FATAL_ERROR "Could not find glfw" )
endif()

configure_file(patch_CMakeLists.txt ${glfw_SOURCE_DIR}/CMakeLists.txt COPYONLY)

if (${CPM_FOR_TOOLCHAIN})
    if (${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be false")
    endif()

    set(CMAKE_INSTALL_PREFIX ${CPM_TOOLCHAIN_CACHE}/glfw)
    set(GLFW_BUILD_EXAMPLES Off)
    set(GLFW_BUILD_TESTS Off)
    set(GLFW_BUILD_DOCS Off)
    set(GLFW_INSTALL On)
    set(GLFW_VULKAN_STATIC Off)
    
    add_subdirectory(${glfw_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/glfw_cpm_toolchain)
else()
    if (NOT ${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be true")
    endif()

    set(CMAKE_INSTALL_PREFIX ${CPM_RUNTIME_CACHE}/glfw)
    set(GLFW_BUILD_EXAMPLES Off)
    set(GLFW_BUILD_TESTS Off)
    set(GLFW_BUILD_DOCS Off)
    set(GLFW_INSTALL On)
    set(GLFW_VULKAN_STATIC Off)
    
    add_subdirectory(${glfw_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/glfw_cpm_runtime)
endif()
