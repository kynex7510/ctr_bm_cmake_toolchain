function(bm_target_linker_file TARGET_NAME LINKER_FILE)
    target_link_options(${TARGET_NAME} PRIVATE -T ${LINKER_FILE})
endfunction()

# From devkitARM.
function(ctr_add_shader_library target)
	cmake_parse_arguments(PARSE_ARGV 1 CTR_PICASSO "" "OUTPUT" "SOURCES")

	if (NOT CTR_PICASSO_EXE)
		message(FATAL_ERROR "Could not find picasso: try installing picasso")
	endif()

	if(DEFINED CTR_PICASSO_OUTPUT)
		get_filename_component(CTR_PICASSO_OUTPUT "${CTR_PICASSO_OUTPUT}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_BINARY_DIR}")
	else()
		set(CTR_PICASSO_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${target}.shbin")
	endif()

	if(NOT DEFINED CTR_PICASSO_SOURCES AND DEFINED CTR_PICASSO_UNPARSED_ARGUMENTS)
		set(CTR_PICASSO_SOURCES "${CTR_PICASSO_UNPARSED_ARGUMENTS}")
	else()
		message(FATAL_ERROR "ctr_add_shader_library: must provide at least one source code file")
	endif()

	add_custom_command(
		OUTPUT "${CTR_PICASSO_OUTPUT}"
		COMMAND "${CTR_PICASSO_EXE}" -o "${CTR_PICASSO_OUTPUT}" ${CTR_PICASSO_SOURCES}
		DEPENDS ${CTR_PICASSO_SOURCES}
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		COMMENT "Building shader library ${target}"
		VERBATIM
	)

	add_custom_target(${target} DEPENDS "${CTR_PICASSO_OUTPUT}")
	dkp_set_target_file(${target} "${CTR_PICASSO_OUTPUT}")
endfunction()