cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  python_cpm
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
    NAME cpython
    GITHUB_REPOSITORY python/cpython
    GIT_TAG v3.6.7
    DOWNLOAD_ONLY true)

CPMAddPackage(
    NAME python-cmake-buildsystem
    GITHUB_REPOSITORY loopunit/python-cmake-buildsystem
    VERSION 3.6.7
    GIT_TAG 3eff883aeef96b3af98a9c9632b12ba721b51e8b
    OPTIONS 
        "DOWNLOADED_SOURCES ${cpython_SOURCE_DIR}"
        "DOWNLOAD_SOURCES false"
        "INSTALL_MANUAL false"
        "INSTALL_TEST false"
        "BUILD_WININST false"
        "CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/python")
