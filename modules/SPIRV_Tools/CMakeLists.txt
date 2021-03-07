cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  SPIRV_Tools_cpm
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
    NAME SPIRV_Tools
    GITHUB_REPOSITORY KhronosGroup/SPIRV-Tools
    GIT_TAG 17ffa89097b26efeb323e6963220326b5ffb2baf
    OPTIONS 
        "ENABLE_CTEST Off"
        "DBUILD_TESTING Off"
        "SPIRV_TOOLS_SKIP_EXAMPLES On"
        "SPIRV-Headers_SOURCE_DIR ${CPM_INSTALL_CACHE}/SPIRV_Headers"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/SPIRV_Tools")
