if(NOT TARGET cpm_toolchain::boostorg_leaf)
	add_cpm_module(boostorg_leaf FOR_TOOLCHAIN)

	add_library(cpm_toolchain::boostorg_leaf INTERFACE)
	target_include_directories(cpm_toolchain::boostorg_leaf INTERFACE ${boostorg_leaf_ROOT}/include)
endif()

####

if(NOT TARGET cpm_runtime::boostorg_leaf)
	add_cpm_module(boostorg_leaf)

	add_library(cpm_runtime::boostorg_leaf INTERFACE)
	target_include_directories(cpm_runtime::boostorg_leaf INTERFACE ${boostorg_leaf_ROOT}/include)
endif()