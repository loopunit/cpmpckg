if(NOT TARGET cpm_install::imgui)
	add_cpm_module(imgui NO_TARGETS)

	add_library(cpm_install::imgui STATIC IMPORTED)
	target_include_directories(cpm_install::imgui INTERFACE ${imgui_ROOT}/include)
	set_target_properties(cpm_install::imgui PROPERTIES IMPORTED_LOCATION ${imgui_ROOT}/lib/imgui.lib)

	#if(MSVC)
	#  if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	#	set_target_properties(cpm_install::imgui PROPERTIES IMPORTED_CONFIGURATIONS "Debug")
	#	set_target_properties(cpm_install::imgui PROPERTIES COMPILE_PDB_NAME imgui COMPILE_PDB_OUTPUT_DIRECTORY "${imgui_ROOT}/lib" )
	#  elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
	#	set_target_properties(cpm_install::imgui PROPERTIES IMPORTED_CONFIGURATIONS "RelWithDebInfo")
	#	set_target_properties(cpm_install::imgui PROPERTIES COMPILE_PDB_NAME imgui COMPILE_PDB_OUTPUT_DIRECTORY "${imgui_ROOT}/lib" )
	#  endif()
	#endif()

endif()