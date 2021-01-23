cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

project(
  cpmpckg
  VERSION 0.0.0
)

include(cmake/add_cpm_module.cmake)

function(CPMAddBaseModule CPM_ARGS_NAME)
	# NOTE: assume cpmpckg was added with cpm
	include(${cpmpckg_SOURCE_DIR}/modules/${CPM_ARGS_NAME}.cmake)
endfunction()