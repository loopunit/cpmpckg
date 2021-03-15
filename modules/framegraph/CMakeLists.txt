cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  FrameGraph_cpm
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

CPMAddBaseModule(glslang)

CPMAddPackage(
    NAME VulkanMemoryAllocator
    GITHUB_REPOSITORY GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator
    GIT_TAG "v2.2.0"
    DOWNLOAD_ONLY true)

if(NOT ${VulkanMemoryAllocator_ADDED})
	message( FATAL_ERROR "Could not find VulkanMemoryAllocator" )
endif()

CPMAddPackage(
    NAME FrameGraph
    GITHUB_REPOSITORY azhirnov/FrameGraph
    GIT_TAG 08271fe48e1bf1fb783b0f21fc6afe5c650cd6ec
    DOWNLOAD_ONLY true)

if(NOT ${FrameGraph_ADDED})
	message( FATAL_ERROR "Could not find FrameGraph" )
endif()

configure_file(patch_CMakeLists.txt                                 ${FrameGraph_SOURCE_DIR}/CMakeLists.txt COPYONLY)
configure_file(patch_framegraph_CMakeLists.txt                      ${FrameGraph_SOURCE_DIR}/framegraph/CMakeLists.txt COPYONLY)
configure_file(patch_stl_CMakeLists.txt                             ${FrameGraph_SOURCE_DIR}/stl/CMakeLists.txt COPYONLY)
configure_file(patch_extensions_vulkan_loader_CMakeLists.txt        ${FrameGraph_SOURCE_DIR}/extensions/vulkan_loader/CMakeLists.txt COPYONLY)
configure_file(patch_extensions_video_CMakeLists.txt                ${FrameGraph_SOURCE_DIR}/extensions/video/CMakeLists.txt COPYONLY)
configure_file(patch_extensions_scene_CMakeLists.txt                ${FrameGraph_SOURCE_DIR}/extensions/scene/CMakeLists.txt COPYONLY)
configure_file(patch_extensions_pipeline_compiler_CMakeLists.txt    ${FrameGraph_SOURCE_DIR}/extensions/pipeline_compiler/CMakeLists.txt COPYONLY)
configure_file(patch_extensions_framework_CMakeLists.txt            ${FrameGraph_SOURCE_DIR}/extensions/framework/CMakeLists.txt COPYONLY)
configure_file(patch_revision.h                                     ${FrameGraph_SOURCE_DIR}/extensions/pipeline_compiler/glslang/Include/revision.h COPYONLY)
configure_file(patch_VulkanSwapchain.h                              ${FrameGraph_SOURCE_DIR}/extensions/framework/Vulkan/VulkanSwapchain.h COPYONLY)
configure_file(patch_project_template.cmake.txt                     ${FrameGraph_SOURCE_DIR}/cmake/patch_project_template.cmake COPYONLY)

set(CMAKE_INSTALL_PREFIX ${CPM_INSTALL_CACHE}/FrameGraph)
set(VulkanMemoryAllocator_SOURCE_DIR ${VulkanMemoryAllocator_SOURCE_DIR})

add_subdirectory(${FrameGraph_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/FrameGraph_cpm_install)

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(FrameGraph PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(FrameGraph PROPERTIES COMPILE_PDB_NAME FrameGraph COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(FrameGraph PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(FrameGraph PROPERTIES COMPILE_PDB_NAME FrameGraph COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(Framework PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(Framework PROPERTIES COMPILE_PDB_NAME Framework COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(Framework PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(Framework PROPERTIES COMPILE_PDB_NAME Framework COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(PipelineCompiler PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(PipelineCompiler PROPERTIES COMPILE_PDB_NAME PipelineCompiler COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(PipelineCompiler PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(PipelineCompiler PROPERTIES COMPILE_PDB_NAME PipelineCompiler COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(STL PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(STL PROPERTIES COMPILE_PDB_NAME STL COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(STL PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(STL PROPERTIES COMPILE_PDB_NAME STL COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()

if(MSVC)
  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set_target_properties(VulkanLoader PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
    set_target_properties(VulkanLoader PROPERTIES COMPILE_PDB_NAME VulkanLoader COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    set_target_properties(VulkanLoader PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
    set_target_properties(VulkanLoader PROPERTIES COMPILE_PDB_NAME VulkanLoader COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
  endif()
endif()
