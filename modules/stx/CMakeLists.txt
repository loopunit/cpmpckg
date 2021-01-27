cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  stx_cpm
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
    NAME stx
	GITHUB_REPOSITORY lamarrr/STX
	GIT_TAG a984c0fe9610548e880e775e279403bd8941d2eb
    DOWNLOAD_ONLY true)

configure_file(patch_CMakeLists.txt ${stx_SOURCE_DIR}/CMakeLists.txt COPYONLY)

if (${CPM_FOR_TOOLCHAIN})
    if (${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be false")
    endif()

    set(CMAKE_INSTALL_PREFIX ${CPM_TOOLCHAIN_CACHE}/stx)
	set(BUILD_TESTING Off)

    add_subdirectory(${stx_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/stx_cpm_toolchain)
else()
    if (NOT ${CPM_FOR_RUNTIME})
        message(FATAL_ERROR "CPM_FOR_RUNTIME should be true")
    endif()
    
    set(CMAKE_INSTALL_PREFIX ${CPM_RUNTIME_CACHE}/stx)
	set(BUILD_TESTING Off)
    
    add_subdirectory(${stx_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/stx_cpm_runtime)
endif()