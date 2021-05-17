if(NOT TARGET cpm_install::libuv)
	add_cpm_module(libuv NO_TARGETS)

	add_library(cpm_install::libuv STATIC IMPORTED)
	target_include_directories(cpm_install::libuv INTERFACE ${libuv_ROOT}/include)
	set_target_properties(cpm_install::libuv PROPERTIES IMPORTED_LOCATION ${libuv_ROOT}/lib/${CMAKE_BUILD_TYPE}/uv_a.lib)
endif()