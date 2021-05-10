if(NOT TARGET cpm_install::boostorg_leaf)
	add_cpm_module(boostorg_leaf NO_TARGETS)

	add_library(
		cpm_install::boostorg_leaf
			INTERFACE IMPORTED)
	
	set_target_properties(cpm_install::boostorg_leaf PROPERTIES 
		INTERFACE_COMPILE_FEATURES 
			cxx_std_20)
	
	target_include_directories(
		cpm_install::boostorg_leaf
		INTERFACE 
			${boostorg_leaf_ROOT}/include)
endif()