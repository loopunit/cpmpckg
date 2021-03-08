set(CPM_SCRIPTS "${CMAKE_CURRENT_LIST_DIR}")

function(add_cpm_module CPM_MODULE_NAME)
    cmake_parse_arguments(add_cpm "" "" "" ${ARGN})
    
    set(MODULE_NAME ${CPM_MODULE_NAME}_ROOT)

    if (DEFINED CPM_DEV_ROOT AND EXISTS "${CPM_DEV_ROOT}/${CPM_MODULE_NAME}.cpmpckg" AND EXISTS "${CPM_DEV_ROOT}/${CPM_MODULE_NAME}.cpmpckg/CMakeLists.txt")
        set(developer_path -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_DEV_ROOT}/${CPM_MODULE_NAME}.cpmpckg})
    elseif (DEFINED CPM_${CPM_MODULE_NAME}_SOURCE)
        set(developer_path -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_${CPM_MODULE_NAME}_SOURCE})
    endif()

    if (DEFINED CPM_DEV_ROOT)
        set(devroot_path -DCPM_DEV_ROOT:PATH=${CPM_DEV_ROOT})
    endif()

    if (DEFINED CPM_DEV_ROOT AND EXISTS "${CPM_DEV_ROOT}/cpmpckg" AND EXISTS "${CPM_DEV_ROOT}/cpmpckg/CMakeLists.txt")
        set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_DEV_ROOT}/cpmpckg)
    elseif (DEFINED CPM_cpmpckg_SOURCE)
        set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_cpmpckg_SOURCE})
    endif()

    message(STATUS "Adding ${CPM_MODULE_NAME} to the install stash.")
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build)
    set(${MODULE_NAME} ${CPM_INSTALL_CACHE}/${CPM_MODULE_NAME})
    
    set(${CPM_MODULE_NAME}_cpm_exists false)
    if(NOT DEFINED developer_path AND EXISTS "${${MODULE_NAME}}" AND IS_DIRECTORY "${${MODULE_NAME}}")
		set(${CPM_MODULE_NAME}_cpm_exists true)
    endif()
	
    if(NOT ${CPM_MODULE_NAME}_cpm_exists)
        execute_process(
            COMMAND ${CMAKE_COMMAND}
                -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
                -DCPM_INSTALL_CACHE:PATH=${CPM_INSTALL_CACHE}
                -DCPM_SCRIPTS:PATH=${CPM_SCRIPTS}
                -DCPM_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                -DCPM_FOR_INSTALL:BOOL=True
                -DCPM_SOURCE_CACHE:PATH=${CPM_SOURCE_CACHE}
                -DCPM_INSTALL_BUILD_CACHE:PATH=${CPM_INSTALL_BUILD_CACHE}
                -Dcpmpckg_SOURCE_DIR:PATH=${cpmpckg_SOURCE_DIR}
                -DCMAKE_INSTALL_PREFIX:PATH=${CPM_INSTALL_CACHE}/${CPM_MODULE_NAME}
                ${cpm_source}
                ${developer_path}
                ${devroot_path}
                -G Ninja
                -S "${cpmpckg_SOURCE_DIR}/modules/${CPM_MODULE_NAME}" 
                -B "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build"
            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build")

        execute_process(
            COMMAND ${CMAKE_COMMAND} 
                --build .
                --target install
                --config ${CMAKE_BUILD_TYPE}
            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build")
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