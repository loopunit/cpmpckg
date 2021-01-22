cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cpmpckg
  VERSION 0.0.0
)

include(cmake/add_cpm_module.cmake)

option(CPM_USE_spirv_headers "" false)
if (${CPM_USE_spirv_headers})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/spirv_headers.cmake)
endif()

option(CPM_USE_spirv_tools "" false)
if (${CPM_USE_spirv_tools})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/spirv_tools.cmake)
endif()

option(CPM_USE_spirv_cross "" false)
if (${CPM_USE_spirv_cross})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/spirv_cross.cmake)
endif()

option(CPM_USE_python "" false)
if (${CPM_USE_python})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/python.cmake)
endif()

option(CPM_USE_glslang "" false)
if (${CPM_USE_glslang})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/glslang.cmake)
endif()

option(CPM_USE_libmdbx "" false)
if (${CPM_USE_libmdbx})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/libmdbx.cmake)
endif()

option(CPM_USE_basis_universal "" false)
if (${CPM_USE_basis_universal})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/basis_universal.cmake)
endif()

option(CPM_USE_glfw "" false)
if (${CPM_USE_glfw})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/glfw.cmake)
endif()

option(CPM_USE_imgui "" false)
if (${CPM_USE_imgui})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/imgui.cmake)
endif()

option(CPM_USE_framegraph "" false)
if (${CPM_USE_framegraph})
	include(${CMAKE_CURRENT_LIST_DIR}/modules/framegraph.cmake)
endif()
