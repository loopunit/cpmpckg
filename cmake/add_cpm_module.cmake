set(CPM_SCRIPTS "${CMAKE_CURRENT_LIST_DIR}")

function(add_cpm_module CPM_MODULE_NAME)
    if(NOT TARGET cpm_install::${CPM_MODULE_NAME})
        message(STATUS "Adding cpm_install::${CPM_MODULE_NAME}")

        cmake_parse_arguments(arg "NO_TARGETS" "" "DEPENDENCIES" ${ARGN})
        
        set(MODULE_NAME ${CPM_MODULE_NAME}_ROOT)
        
        if(DEFINED CPM_DEV_ROOT)
            get_filename_component(CPM_DEV_ROOT_ABS ${CPM_DEV_ROOT} ABSOLUTE)
        endif()

        if(DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg" AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg/CMakeLists.txt")
            set(developer_path ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)
            set(developer_path_arg -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)
        elseif(DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}" AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}/CMakeLists.txt")
            set(developer_path ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)    
            set(developer_path_arg -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME})
        else()
            unset(developer_path)
            unset(developer_path_arg)
        endif()

        if (DEFINED developer_path)
            message(STATUS "Including ${CPM_MODULE_NAME} from the development root: ${developer_path}.")
            add_subdirectory(${developer_path} ${CMAKE_CURRENT_BINARY_DIR}/${CPM_MODULE_NAME})
            add_library(cpm_install::${CPM_MODULE_NAME} ALIAS ${CPM_MODULE_NAME})
        else()
            if (DEFINED CPM_DEV_ROOT_ABS)
                set(devroot_path -DCPM_DEV_ROOT_ABS:PATH=${CPM_DEV_ROOT_ABS})
            endif()

            if (DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/cpmpckg" AND EXISTS "${CPM_DEV_ROOT_ABS}/cpmpckg/CMakeLists.txt")
                set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/cpmpckg)
            elseif (DEFINED CPM_cpmpckg_SOURCE)
                set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_cpmpckg_SOURCE})
            endif()

            message(STATUS "Adding ${CPM_MODULE_NAME} to the install stash.")
            file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build)
            set(${MODULE_NAME} ${CPM_INSTALL_CACHE}/${CPM_MODULE_NAME})
            
            set(${CPM_MODULE_NAME}_cpm_exists false)
            if(NOT DEFINED developer_path_arg AND EXISTS "${${MODULE_NAME}}" AND IS_DIRECTORY "${${MODULE_NAME}}")
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
                        ${developer_path_arg}
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
        
            if(NOT ${arg_NO_TARGETS})
                # TODO: obviously lacking target flexibility here...
                add_library(cpm_install::${CPM_MODULE_NAME} STATIC IMPORTED)
                target_include_directories(cpm_install::${CPM_MODULE_NAME} INTERFACE ${${CPM_MODULE_NAME}_ROOT}/include)
                set_target_properties(cpm_install::${CPM_MODULE_NAME} PROPERTIES IMPORTED_LOCATION ${${CPM_MODULE_NAME}_ROOT}/lib/${CPM_MODULE_NAME}.lib)
                if (DEFINED arg_DEPENDENCIES)
                    target_link_libraries(cpm_install::${CPM_MODULE_NAME} INTERFACE ${arg_DEPENDENCIES})
                endif()
            endif()
        endif()
    endif()
endfunction()

function(CPMAddBaseModule CPM_ARGS_NAME)
	# NOTE: assume cpmpckg was added with cpm
	if(NOT TARGET cpm_install::${CPM_ARGS_NAME})
        include(${cpmpckg_SOURCE_DIR}/modules/${CPM_ARGS_NAME}.cmake)
    endif()
endfunction()

#function(CPMAddModule CPM_ARGS_NAME)
#	# NOTE: assume cpmpckg was added with cpm
#	include(${${CPM_ARGS_NAME}_SOURCE_DIR}/modules/${CPM_ARGS_NAME}.cmake)
#endfunction()