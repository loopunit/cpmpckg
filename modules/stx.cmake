add_cpm_module(stx FOR_TOOLCHAIN)

add_library(cpm_toolchain::stx STATIC IMPORTED)
target_include_directories(cpm_toolchain::stx INTERFACE ${stx_ROOT}/include)
set_target_properties(cpm_toolchain::stx PROPERTIES IMPORTED_LOCATION ${stx_ROOT}/lib/stx.lib)

####

add_cpm_module(stx)

add_library(cpm_runtime::stx STATIC IMPORTED)
target_include_directories(cpm_runtime::stx INTERFACE ${stx_ROOT}/include)
set_target_properties(cpm_runtime::stx PROPERTIES IMPORTED_LOCATION ${stx_ROOT}/lib/stx.lib)