if(NOT TARGET cpm_install::stx)
	add_cpm_module(stx NO_TARGETS)

	add_library(cpm_install::stx STATIC IMPORTED)
	target_include_directories(cpm_install::stx INTERFACE ${stx_ROOT}/include)
	set_target_properties(cpm_install::stx PROPERTIES IMPORTED_LOCATION ${stx_ROOT}/lib/stx.lib)
endif()