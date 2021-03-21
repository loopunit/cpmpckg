if(NOT TARGET cpm_install::diligent_engine)
	add_cpm_module(diligent_engine NO_TARGETS)

	add_library(cpm_install::diligent_fx STATIC IMPORTED)
	target_include_directories(cpm_install::diligent_fx INTERFACE ${diligent_engine_ROOT}/include/DiligentFX)
	set_target_properties(cpm_install::diligent_fx PROPERTIES IMPORTED_LOCATION ${diligent_engine_ROOT}/lib/DiligentFX/${CMAKE_BUILD_TYPE}/DiligentFX.lib)
	
	add_library(cpm_install::diligent_tools STATIC IMPORTED)
	target_include_directories(cpm_install::diligent_tools INTERFACE ${diligent_engine_ROOT}/include/DiligentTools)
	set_target_properties(cpm_install::diligent_tools PROPERTIES IMPORTED_LOCATION ${diligent_engine_ROOT}/lib/DiligentTools/${CMAKE_BUILD_TYPE}/DiligentTools.lib)
	
	add_library(cpm_install::diligent_engine STATIC IMPORTED)
	target_include_directories(cpm_install::diligent_engine INTERFACE ${diligent_engine_ROOT}/include/DiligentCore)
	set_target_properties(cpm_install::diligent_engine PROPERTIES IMPORTED_LOCATION ${diligent_engine_ROOT}/lib/DiligentCore/${CMAKE_BUILD_TYPE}/DiligentCore.lib)
	target_compile_definitions(cpm_install::diligent_engine INTERFACE PLATFORM_WIN32=1)
	target_link_libraries(cpm_install::diligent_engine INTERFACE cpm_install::diligent_fx cpm_install::diligent_tools)
	
	if(WIN32)
		target_link_libraries(cpm_install::diligent_engine INTERFACE DXGI.lib d3dcompiler.lib)
	endif()
endif()