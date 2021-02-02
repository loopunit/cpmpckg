if(NOT TARGET cpm_runtime::imgui_app_fw)
	CPMAddBaseModule(imgui)
	CPMAddBaseModule(glfw)
	CPMAddBaseModule(framegraph)
	CPMAddBaseModule(basis_universal)
	CPMAddBaseModule(mu_stdlib)

	add_cpm_module(imgui_app_fw)

	add_library(cpm_runtime::imgui_app_fw STATIC IMPORTED)
	target_include_directories(cpm_runtime::imgui_app_fw INTERFACE ${imgui_app_fw_ROOT}/include)
	target_link_libraries(cpm_runtime::imgui_app_fw INTERFACE cpm_runtime::imgui cpm_runtime::glfw cpm_runtime::framegraph cpm_runtime::basis_universal cpm_runtime::mu_stdlib)
	set_target_properties(cpm_runtime::imgui_app_fw PROPERTIES IMPORTED_LOCATION ${imgui_app_fw_ROOT}/lib/imgui_app_fw.lib)
endif()