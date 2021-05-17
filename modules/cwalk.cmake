if(NOT TARGET cpm_install::cwalk)
	add_cpm_module(cwalk NO_TARGETS)

	add_library(cpm_install::cwalk INTERFACE IMPORTED)
	target_include_directories(cpm_install::cwalk INTERFACE ${cwalk_ROOT}/include)
endif()