if(NOT TARGET cpm_install::imgui_addons)
	CPMAddBaseModule(imgui)	
	
	add_cpm_module(imgui_addons)
endif()