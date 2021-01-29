CPMAddBaseModule(imgui_app_fw)
CPMAddBaseModule(imgui_addons)

add_cpm_module(imgui_app)

add_library(cpm_runtime::imgui_app STATIC IMPORTED)
target_include_directories(cpm_runtime::imgui_app INTERFACE ${imgui_app_ROOT}/include)
set_target_properties(cpm_runtime::imgui_app PROPERTIES IMPORTED_LOCATION ${imgui_app_ROOT}/lib/imgui_app.lib)
target_link_libraries(cpm_runtime::imgui_app INTERFACE cpm_runtime::imgui_addons cpm_runtime::imgui_app_fw)
