if(NOT TARGET cpm_install::taskflow)
	add_cpm_module(taskflow NO_TARGETS)

	add_library(cpm_install::taskflow INTERFACE IMPORTED)
	target_include_directories(cpm_install::taskflow INTERFACE ${taskflow_ROOT}/include)
	set_target_properties(cpm_install::taskflow PROPERTIES INTERFACE_LINK_LIBRARIES "Threads::Threads")
endif()