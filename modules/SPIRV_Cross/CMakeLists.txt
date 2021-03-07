cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  SPIRV_Cross_cpm
  VERSION 1.0
  LANGUAGES CXX
)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR
   "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.")
endif()

include(ExternalProject)
include(${CPM_SCRIPTS}/CPM.cmake)
include(${CPM_SCRIPTS}/add_cpm_module.cmake)

CPMAddBaseModule(spirv_headers)

CPMAddPackage(
    NAME SPIRV_Cross
    GITHUB_REPOSITORY KhronosGroup/SPIRV-Cross
    GIT_TAG e50f7d1ce8e162d0c826e84168cfa234e4de4ec9
    OPTIONS 
        "ENABLE_CTEST Off"
        "DBUILD_TESTING Off"
        "SPIRV_HEADERS_SKIP_EXAMPLES On"
        "SPIRV-Headers_SOURCE_DIR ${CPM_INSTALL_CACHE}/SPIRV_Headers"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/SPIRV_Cross")
