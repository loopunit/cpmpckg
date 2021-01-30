if(NOT TARGET cpm_toolchain::leaf)
	add_cpm_module(leaf FOR_TOOLCHAIN)

	add_library(cpm_toolchain::leaf INTERFACE)
	target_include_directories(cpm_toolchain::leaf INTERFACE ${leaf_ROOT}/include)
endif()

####

if(NOT TARGET cpm_runtime::leaf)
	add_cpm_module(leaf)

	add_library(cpm_runtime::leaf INTERFACE)
	target_include_directories(cpm_runtime::leaf INTERFACE ${leaf_ROOT}/include)
endif()