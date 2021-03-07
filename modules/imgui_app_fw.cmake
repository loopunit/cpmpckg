if(NOT TARGET cpm_install::imgui_app_fw)
	CPMAddBaseModule(imgui)
	CPMAddBaseModule(glfw)
	CPMAddBaseModule(framegraph)
	CPMAddBaseModule(basis_universal)
	CPMAddBaseModule(mu_stdlib)

	add_cpm_module(imgui_app_fw)

	add_library(cpm_install::imgui_app_fw STATIC IMPORTED)
	target_include_directories(cpm_install::imgui_app_fw INTERFACE ${imgui_app_fw_ROOT}/include)
	target_link_libraries(cpm_install::imgui_app_fw INTERFACE cpm_install::imgui cpm_install::glfw cpm_install::framegraph cpm_install::basis_universal cpm_install::mu_stdlib)
	set_target_properties(cpm_install::imgui_app_fw PROPERTIES IMPORTED_LOCATION ${imgui_app_fw_ROOT}/lib/imgui_app_fw.lib)
endif()