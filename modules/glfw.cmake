if(NOT TARGET cpm_install::glfw)
	add_cpm_module(glfw)
	
	include(${glfw_ROOT}/lib/cmake/glfw3/glfw3Config.cmake)
	add_library(cpm_install::glfw ALIAS glfw)
endif()