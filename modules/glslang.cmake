if(NOT TARGET cpm_install::glslang)
	add_cpm_module(glslang NO_TARGETS)
	
	include(${glslang_ROOT}/lib/cmake/HLSLTargets.cmake)
	include(${glslang_ROOT}/lib/cmake/OGLCompilerTargets.cmake)
	include(${glslang_ROOT}/lib/cmake/OSDependentTargets.cmake)
	include(${glslang_ROOT}/lib/cmake/SPVRemapperTargets.cmake)
	include(${glslang_ROOT}/lib/cmake/glslangTargets.cmake)
	include(${glslang_ROOT}/lib/cmake/SPIRVTargets.cmake)
	add_library(cpm_install::glslang ALIAS glslang)
	add_library(cpm_install::spirv ALIAS SPIRV)
endif()