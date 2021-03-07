if(NOT TARGET cpm_install::mu_stdlib)
	CPMAddBaseModule(boostorg_leaf)

	add_cpm_module(mu_stdlib)

	add_library(cpm_install::mu_stdlib STATIC IMPORTED)
	target_include_directories(cpm_install::mu_stdlib INTERFACE ${mu_stdlib_ROOT}/include)
	target_link_libraries(cpm_install::mu_stdlib INTERFACE cpm_install::boostorg_leaf)
	set_target_properties(cpm_install::mu_stdlib PROPERTIES IMPORTED_LOCATION ${mu_stdlib_ROOT}/lib/mu_stdlib.lib)
endif()