if(NOT TARGET cpm_install::mu_stdlib)
	CPMAddBaseModule(boostorg_leaf)

	add_cpm_module(mu_stdlib
		DEPENDENCIES
			cpm_install::boostorg_leaf)
endif()