set(CPM_SCRIPTS "${CMAKE_CURRENT_LIST_DIR}")

function(add_cpm_module CPM_MODULE_NAME)
    cmake_parse_arguments(add_cpm "FOR_RUNTIME;FOR_TOOLCHAIN" "" "" ${ARGN})
    
    set(MODULE_NAME ${CPM_MODULE_NAME}_ROOT)

    if (${add_cpm_FOR_TOOLCHAIN})
        message(STATUS "Adding ${CPM_MODULE_NAME} to the toolchain stash.")
        file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_toolchain_build)
        set(${MODULE_NAME} ${CPM_TOOLCHAIN_CACHE}/${CPM_MODULE_NAME})
    else()
        message(STATUS "Adding ${CPM_MODULE_NAME} to the runtime stash.")
        file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_runtime_build)
        set(${MODULE_NAME} ${CPM_RUNTIME_CACHE}/${CPM_MODULE_NAME})
    endif()
    
    set(${CPM_MODULE_NAME}_cpm_exists false)
    #if(EXISTS "${${MODULE_NAME}}" AND IS_DIRECTORY "${${MODULE_NAME}}")
    #    set(${CPM_MODULE_NAME}_cpm_exists true)
    #endif()

    if(NOT ${CPM_MODULE_NAME}_cpm_exists)
        if (${add_cpm_FOR_TOOLCHAIN})
            execute_process(
                COMMAND ${CMAKE_COMMAND}
                    -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
		            -DCPM_TOOLCHAIN_CACHE:PATH=${CPM_TOOLCHAIN_CACHE}
                    -DCPM_RUNTIME_CACHE:PATH=${CPM_RUNTIME_CACHE}
                    -DCPM_SCRIPTS:PATH=${CPM_SCRIPTS}
                    -DCPM_BUILD_TYPE:STRING=Release
                    -DCPM_FOR_TOOLCHAIN:BOOL=True
                    -DCPM_FOR_RUNTIME:BOOL=False
                    -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
                    -DCPM_RUNTIME_BUILD_CACHE:PATH=${CPM_RUNTIME_BUILD_CACHE}
                    -Dcpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}
                    -G Ninja
		            -S "${cpmpckg_SOURCE_DIR}/modules/${CPM_MODULE_NAME}" 
		            -B "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_toolchain_build"
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_toolchain_build")

            execute_process(
                COMMAND ${CMAKE_COMMAND} 
		            --build .
	                --target install
                    --config Release
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_toolchain_build")
        else()
            execute_process(
                COMMAND ${CMAKE_COMMAND}
                    -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
		            -DCPM_TOOLCHAIN_CACHE:PATH=${CPM_TOOLCHAIN_CACHE}
                    -DCPM_RUNTIME_CACHE:PATH=${CPM_RUNTIME_CACHE}
                    -DCPM_SCRIPTS:PATH=${CPM_SCRIPTS}
                    -DCPM_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                    -DCPM_FOR_TOOLCHAIN:BOOL=False
                    -DCPM_FOR_RUNTIME:BOOL=True
                    -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
                    -DCPM_RUNTIME_BUILD_CACHE:PATH=${CPM_RUNTIME_BUILD_CACHE}
                    -Dcpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}
		            -S "${cpmpckg_SOURCE_DIR}/modules/${CPM_MODULE_NAME}" 
                    -G Ninja
		            -B "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_runtime_build"
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_runtime_build")

            execute_process(
                COMMAND ${CMAKE_COMMAND} 
		            --build .
	                --target install
                    --config ${CMAKE_BUILD_TYPE}
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_runtime_build")
        endif()
    endif()
    
    set(${MODULE_NAME} ${${MODULE_NAME}} PARENT_SCOPE)

endfunction()

function(CPMAddBaseModule CPM_ARGS_NAME)
	# NOTE: assume cpmpckg was added with cpm
	include(${cpmpckg_SOURCE_DIR}/modules/${CPM_ARGS_NAME}.cmake)
endfunction()

function(CPMAddModule CPM_ARGS_NAME)
	# NOTE: assume cpmpckg was added with cpm
	include(${${CPM_ARGS_NAME}_SOURCE_DIR}/modules/${CPM_ARGS_NAME}.cmake)
endfunction()