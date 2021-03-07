cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  SPIRV_Headers_cpm
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
    NAME SPIRV_Headers
    GITHUB_REPOSITORY KhronosGroup/SPIRV-Headers
    GIT_TAG f027d53ded7e230e008d37c8b47ede7cd308e19d
    OPTIONS 
        "SPIRV_HEADERS_SKIP_INSTALL Off"
        "SPIRV_HEADERS_SKIP_EXAMPLES On"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/SPIRV_Headers")
