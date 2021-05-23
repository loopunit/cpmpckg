if(NOT TARGET cpm_install::llfio)
	add_cpm_module(llfio NO_TARGETS)
	
	#add_library(cpm_install::llfio STATIC IMPORTED)
	#target_include_directories(cpm_install::llfio INTERFACE ${llfio_ROOT}/include)
	#set_target_properties(cpm_install::llfio PROPERTIES IMPORTED_LOCATION ${llfio_ROOT}/lib/basis.lib)
	#target_compile_definitions(cpm_install::llfio INTERFACE BASISU_NO_ITERATOR_DEBUG_LEVEL)
endif()