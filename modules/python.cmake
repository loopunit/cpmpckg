if(NOT DEFINED Python3_ROOT_DIR)
	add_cpm_module(python)

	set(Python3_ROOT_DIR ${python_ROOT})
	find_package(Python3 COMPONENTS Interpreter Development)
endif()