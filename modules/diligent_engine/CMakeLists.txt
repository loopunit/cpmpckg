cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  diligent_engine
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
	NAME diligent_engine
	GITHUB_REPOSITORY DiligentGraphics/DiligentEngine
	GIT_TAG 29c34ef834111a1dfb7da3cc71c478d08db60f69
	DOWNLOAD_ONLY TRUE)

if(NOT ${diligent_engine_ADDED})
	message( FATAL_ERROR "Could not find diligent_engine" )
endif()

execute_process(
	COMMAND ${CMAKE_COMMAND}
		-DCMAKE_INSTALL_PREFIX:PATH=${CPM_INSTALL_CACHE}/diligent_engine
		-DDILIGENT_BUILD_TESTS:BOOL=False
		-DDILIGENT_BUILD_SAMPLES:BOOL=False
		-DDILIGENT_BUILD_DEMOS:BOOL=False
		-DDILIGENT_BUILD_UNITY_PLUGIN:BOOL=False
		-DDILIGENT_NO_DIRECT3D11:BOOL=True
		-DDILIGENT_NO_OPENGL:BOOL=True
		-DDILIGENT_NO_VULKAN:BOOL=True
		-DDILIGENT_NO_FORMAT_VALIDATION:BOOL=True
		${cpm_source}
		${developer_path_arg}
		${devroot_path}
		-G "Visual Studio 16 2019"
		-S "${diligent_engine_SOURCE_DIR}" 
		-B "${CMAKE_BINARY_DIR}"
	WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")

execute_process(
	COMMAND ${CMAKE_COMMAND} 
		--build .
		--target ALL_BUILD
		--config ${CMAKE_BUILD_TYPE}
	WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")

execute_process(
	COMMAND ${CMAKE_COMMAND} 
		--build .
		--target install
		--config ${CMAKE_BUILD_TYPE}
	WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")

#if(MSVC)
#  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
#    set_target_properties(diligent_engine PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
#    set_target_properties(diligent_engine PROPERTIES COMPILE_PDB_NAME diligent_engine COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
#  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
#    set_target_properties(diligent_engine PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
#    set_target_properties(diligent_engine PROPERTIES COMPILE_PDB_NAME diligent_engine COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib" )
#  endif()
#endif()
