if(NOT TARGET cpm_install::mdbx)
	add_cpm_module(mdbx NO_TARGETS)

	add_library(mdbx_install STATIC IMPORTED)
	set_target_properties(mdbx_install PROPERTIES IMPORTED_LOCATION ${mdbx_ROOT}/lib/mdbx.lib)
	target_include_directories(mdbx_install INTERFACE ${mdbx_ROOT}/include)
	add_library(cpm_install::mdbx ALIAS mdbx_install)
endif()