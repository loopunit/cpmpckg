if(NOT TARGET cpm_install::imgui_app)
	CPMAddBaseModule(imgui_addons)
	CPMAddBaseModule(imgui_app_fw)

	add_cpm_module(imgui_app 
		DEPENDENCIES 
			cpm_install::imgui_addons 
			cpm_install::imgui_app_fw)
endif()