if(NOT TARGET cpm_install::imgui)
	add_cpm_module(imgui)

	add_library(cpm_install::imgui STATIC IMPORTED)
	target_include_directories(cpm_install::imgui INTERFACE ${imgui_ROOT}/include)
	set_target_properties(cpm_install::imgui PROPERTIES IMPORTED_LOCATION ${imgui_ROOT}/lib/imgui.lib)
endif()