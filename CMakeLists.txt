cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cpmpckg
  VERSION 0.0.0
)

option(CPM_BUILD_TEST "" off)

set(cpmpckg_SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}")
include(cmake/add_cpm_module.cmake)

if (${CPM_BUILD_TEST})
	#CPMAddBaseModule(imgui)
	#CPMAddBaseModule(libmdbx)
	#CPMAddBaseModule(python)
	#CPMAddBaseModule(spirv_headers)
	#CPMAddBaseModule(spirv_cross)
	#CPMAddBaseModule(spirv_tools)
	#CPMAddBaseModule(basis_universal)
	#CPMAddBaseModule(glfw)
	#CPMAddBaseModule(glslang)
	#CPMAddBaseModule(framegraph)
	#CPMAddBaseModule(stx)
	
	#add_executable(test test/main.cpp)
	#set_target_properties(test PROPERTIES CXX_STANDARD 17)
endif()