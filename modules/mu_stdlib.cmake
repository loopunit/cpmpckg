if(NOT TARGET cpm_runtime::mu_stdlib)
	CPMAddBaseModule(boostorg_leaf)

	add_cpm_module(mu_stdlib)

	add_library(cpm_runtime::mu_stdlib STATIC IMPORTED)
	target_include_directories(cpm_runtime::mu_stdlib INTERFACE ${mu_stdlib_ROOT}/include)
	set_target_properties(cpm_runtime::mu_stdlib PROPERTIES IMPORTED_LOCATION ${mu_stdlib_ROOT}/lib/mu_stdlib.lib)
endif()