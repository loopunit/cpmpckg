cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cpmpckg
  VERSION 0.0.0
)

option(CPM_BUILD_TEST "" off)

set(cpmpckg_SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}")
include(cmake/add_cpm_module.cmake)

if (${CPM_BUILD_TEST})
	CPMAddBaseModule(glfw)
	add_executable(glfw_test test/glfw_main.cpp)
	target_include_directories(glfw_test PUBLIC src)
	target_link_libraries(glfw_test PUBLIC cpm_install::glfw)
	set_target_properties(glfw_test PROPERTIES CXX_STANDARD 17)

	CPMAddBaseModule(mu_stdlib)
	add_executable(mu_stdlib_test test/mu_stdlib_main.cpp)
	target_include_directories(mu_stdlib_test PUBLIC src)
	target_link_libraries(mu_stdlib_test PUBLIC cpm_install::mu_stdlib)
	set_target_properties(mu_stdlib_test PROPERTIES CXX_STANDARD 17)

	CPMAddBaseModule(imgui_app_fw)
	add_executable(imgui_app_fw_test test/imgui_app_fw_main.cpp)
	target_include_directories(imgui_app_fw_test PUBLIC src)
	target_link_libraries(imgui_app_fw_test PUBLIC cpm_install::imgui_app_fw)
	set_target_properties(imgui_app_fw_test PROPERTIES CXX_STANDARD 17)
	
	CPMAddBaseModule(imgui_app)
	add_executable(test test/main.cpp)
	target_include_directories(test PUBLIC src)
	target_link_libraries(test 
		PUBLIC cpm_install::imgui_app_fw cpm_install::imgui_addons cpm_install::imgui_app)
	set_target_properties(test PROPERTIES CXX_STANDARD 17)
endif()