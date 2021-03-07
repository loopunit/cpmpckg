if(NOT TARGET cpm_install::imgui_addons)
	CPMAddBaseModule(imgui)	
	
	add_cpm_module(imgui_addons)

	add_library(cpm_install::imgui_addons STATIC IMPORTED)
	target_include_directories(cpm_install::imgui_addons INTERFACE ${imgui_addons_ROOT}/include)
	set_target_properties(cpm_install::imgui_addons PROPERTIES IMPORTED_LOCATION ${imgui_addons_ROOT}/lib/imgui_addons.lib)
endif()