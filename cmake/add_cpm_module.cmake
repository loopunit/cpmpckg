set(CPM_SCRIPTS "${CMAKE_CURRENT_LIST_DIR}")

if(DEFINED CPM_INSTALL_CACHE)
    get_filename_component(CPM_INSTALL_CACHE_ABS ${CPM_INSTALL_CACHE} ABSOLUTE)
    set(CPM_INSTALL_CACHE ${CPM_INSTALL_CACHE_ABS})
endif()

if(DEFINED CPM_SOURCE_CACHE)
    get_filename_component(CPM_SOURCE_CACHE_ABS ${CPM_SOURCE_CACHE} ABSOLUTE)
    set(CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE_ABS})
endif()

function(add_cpm_module CPM_MODULE_NAME)
    if(NOT TARGET cpm_install::${CPM_MODULE_NAME})
        message(STATUS "CPMPCKG: Adding cpm_install::${CPM_MODULE_NAME}")

        cmake_parse_arguments(arg "NO_TARGETS" "" "DEPENDENCIES" ${ARGN})
        
        set(MODULE_NAME_ROOT_VAR ${CPM_MODULE_NAME}_ROOT)
        
        if(DEFINED CPM_DEV_ROOT)
        message(STATUS "CPMPCKG: Resolving CPM_DEV_ROOT")
            get_filename_component(CPM_DEV_ROOT_ABS ${CPM_DEV_ROOT} ABSOLUTE)
        endif()

        if(DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg" AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg/CMakeLists.txt")
        message(STATUS "CPMPCKG: Using dev repository: ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg")
            set(developer_path ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)
            set(developer_path_arg -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)
        elseif(DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}" AND EXISTS "${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}/CMakeLists.txt")
        message(STATUS "CPMPCKG: Using dev repository: ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}")
            set(developer_path ${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME}.cpmpckg)    
            set(developer_path_arg -DCPM_${CPM_MODULE_NAME}_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/${CPM_MODULE_NAME})
        else()
        message(STATUS "CPMPCKG: No dev repository found")
            unset(developer_path)
            unset(developer_path_arg)
        endif()

        if(DEFINED developer_path)
        message(STATUS "CPMPCKG: Including ${CPM_MODULE_NAME} from the development root: ${developer_path}")
            add_subdirectory(${developer_path} ${CMAKE_CURRENT_BINARY_DIR}/${CPM_MODULE_NAME})
            add_library(cpm_install::${CPM_MODULE_NAME} ALIAS ${CPM_MODULE_NAME})
        else()
        message(STATUS "CPMPCKG: Including ${CPM_MODULE_NAME}")
            
            if(DEFINED CPM_DEV_ROOT_ABS)
            message(STATUS "CPMPCKG: Using CPM_DEV_ROOT: ${CPM_DEV_ROOT_ABS}")
                set(devroot_path -DCPM_DEV_ROOT_ABS:PATH=${CPM_DEV_ROOT_ABS})
            endif()

            if(DEFINED CPM_DEV_ROOT_ABS AND EXISTS "${CPM_DEV_ROOT_ABS}/cpmpckg" AND EXISTS "${CPM_DEV_ROOT_ABS}/cpmpckg/CMakeLists.txt")
            message(STATUS "CPMPCKG: CPM_cpmpckg_SOURCE lives in the dev root: ${CPM_DEV_ROOT_ABS}/cpmpckg")
                set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_DEV_ROOT_ABS}/cpmpckg)
            elseif(DEFINED CPM_cpmpckg_SOURCE)
            message(STATUS "CPMPCKG: CPM_cpmpckg_SOURCE lives in: ${CPM_cpmpckg_SOURCE}")
                set(cpm_source -DCPM_cpmpckg_SOURCE:PATH=${CPM_cpmpckg_SOURCE})
            endif()

            message(STATUS "CPMPCKG: Adding ${CPM_MODULE_NAME} to the install stash.")
            file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${CPM_MODULE_NAME}_cpm_install_build)
            
            get_filename_component(MODULE_NAME_ROOT_VAR_TMP ${CPM_INSTALL_CACHE}/${CPM_MODULE_NAME} ABSOLUTE)
            set(${MODULE_NAME_ROOT_VAR} ${MODULE_NAME_ROOT_VAR_TMP})
            
            set(${CPM_MODULE_NAME}_cpm_exists false)
            if(NOT DEFINED developer_path_arg AND EXISTS "${${MODULE_NAME_ROOT_VAR}}" AND IS_DIRECTORY "${${MODULE_NAME_ROOT_VAR}}")
            message(STATUS "CPMPCKG: ${MODULE_NAME_ROOT_VAR} already exists")
                set(${CPM_MODULE_NAME}_cpm_exists true)
            endif()
            
            if(NOT DEFINED CPM_INSTALL_BUILD_CACHE)
                set(CPM_INSTALL_BUILD_CACHE "${CMAKE_BINARY_DIR}/cpm-build-cache")
                message(STATUS "CPMPCKG: CPM_INSTALL_BUILD_CACHE is at ${CPM_INSTALL_BUILD_CACHE}")
            endif()

            if(NOT ${CPM_MODULE_NAME}_cpm_exists)
                message(STATUS "CPMPCKG: Building ${CPM_MODULE_NAME}")

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
            
            set(${MODULE_NAME_ROOT_VAR} ${${MODULE_NAME_ROOT_VAR}} PARENT_SCOPE)
        
            if(NOT ${arg_NO_TARGETS})
                message(STATUS "CPMPCKG: Installing module targets")
                
                # TODO: obviously lacking target flexibility here...
                add_library(cpm_install::${CPM_MODULE_NAME} STATIC IMPORTED)
                target_include_directories(cpm_install::${CPM_MODULE_NAME} INTERFACE ${${CPM_MODULE_NAME}_ROOT}/include)
                set_target_properties(cpm_install::${CPM_MODULE_NAME} PROPERTIES IMPORTED_LOCATION ${${CPM_MODULE_NAME}_ROOT}/lib/${CPM_MODULE_NAME}.lib)
                
                if(DEFINED arg_DEPENDENCIES)
                    message(STATUS "CPMPCKG: Adding module dependencies: ${arg_DEPENDENCIES}")
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

