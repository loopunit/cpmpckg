if(NOT TARGET cpm_install::mu_gfx)
	CPMAddBaseModule(diligent_engine)

	add_cpm_module(mu_gfx
		DEPENDENCIES
			cpm_install::diligent_engine)
endif()