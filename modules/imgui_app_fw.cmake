if(NOT TARGET cpm_install::imgui_app_fw)
	CPMAddBaseModule(imgui)
	CPMAddBaseModule(glfw)
	CPMAddBaseModule(framegraph)
	CPMAddBaseModule(basis_universal)
	CPMAddBaseModule(mu_stdlib)

	add_cpm_module(imgui_app_fw
		DEPENDENCIES
			cpm_install::imgui 
			cpm_install::glfw 
			cpm_install::framegraph 
			cpm_install::basis_universal 
			cpm_install::mu_stdlib)
endif()