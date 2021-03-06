if(NOT TARGET cpm_install::framegraph_framework OR NOT TARGET cpm_install::framegraph_vulkanloader OR NOT TARGET cpm_install::framegraph_stl OR NOT TARGET cpm_install::framegraph_pipelinecompiler OR NOT TARGET cpm_install::framegraph)
	CPMAddBaseModule(glslang)

	add_cpm_module(framegraph NO_TARGETS)
	add_library(cpm_install::framegraph_framework STATIC IMPORTED)
	set_target_properties(cpm_install::framegraph_framework PROPERTIES IMPORTED_LOCATION ${framegraph_ROOT}/lib/Framework.lib)

	add_library(cpm_install::framegraph_vulkanloader STATIC IMPORTED)
	set_target_properties(cpm_install::framegraph_vulkanloader PROPERTIES IMPORTED_LOCATION ${framegraph_ROOT}/lib/VulkanLoader.lib)

	add_library(cpm_install::framegraph_stl STATIC IMPORTED)
	set_target_properties(cpm_install::framegraph_stl PROPERTIES IMPORTED_LOCATION ${framegraph_ROOT}/lib/STL.lib)

	add_library(cpm_install::framegraph_pipelinecompiler STATIC IMPORTED)
	set_target_properties(cpm_install::framegraph_pipelinecompiler PROPERTIES IMPORTED_LOCATION ${framegraph_ROOT}/lib/PipelineCompiler.lib)

	add_library(cpm_install::framegraph STATIC IMPORTED)
	set_target_properties(cpm_install::framegraph PROPERTIES IMPORTED_LOCATION ${framegraph_ROOT}/lib/FrameGraph.lib)
	target_include_directories(cpm_install::framegraph INTERFACE ${framegraph_ROOT}/include)
	target_include_directories(cpm_install::framegraph INTERFACE ${framegraph_ROOT}/include/vulkan_loader/1.1)
	target_compile_definitions(cpm_install::framegraph INTERFACE FG_ENABLE_VULKAN=1 FG_ENABLE_VULKAN_MEMORY_ALLOCATOR=1 COMPILER_MSVC=1 FG_STD_VARIANT=1 FG_STD_OPTIONAL=1 FG_STD_STRINGVIEW=1 FG_CACHE_LINE=std::hardware_destructive_interference_size FG_HAS_HASHFN_HashArrayRepresentation=1 FG_HAS_HASHFN_HashBytes=1 FG_HAS_HASHFN_Murmur2OrCityhash=1 FG_VULKAN_TARGET_VERSION="110")
	target_link_libraries(cpm_install::framegraph INTERFACE cpm_install::framegraph_framework cpm_install::framegraph_vulkanloader cpm_install::framegraph_stl cpm_install::framegraph_pipelinecompiler)
	target_link_libraries(cpm_install::framegraph INTERFACE cpm_install::glslang cpm_install::spirv)
endif()