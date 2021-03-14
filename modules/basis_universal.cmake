if(NOT TARGET cpm_install::basis_universal)
	add_cpm_module(basis_universal NO_TARGETS)
	
	add_library(cpm_install::basis_universal STATIC IMPORTED)
	target_include_directories(cpm_install::basis_universal INTERFACE ${basis_universal_ROOT}/include)
	set_target_properties(cpm_install::basis_universal PROPERTIES IMPORTED_LOCATION ${basis_universal_ROOT}/lib/basis.lib)
	target_compile_definitions(cpm_install::basis_universal INTERFACE BASISU_NO_ITERATOR_DEBUG_LEVEL)
endif()