if(NOT TARGET cpm_install::mu_stdlib)
	CPMAddBaseModule(boostorg_leaf)

	add_cpm_module(mu_stdlib
		DEPENDENCIES
			cpm_install::boostorg_leaf)

	# TODO: this option needs to be added somehow so cached builds
	# respect the inherited options.
	#target_compile_options(cpm_install::mu_stdlib PUBLIC /we4715)
endif()