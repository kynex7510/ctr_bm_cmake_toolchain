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

function(ctr_add_graphics_target target kind)
    cmake_parse_arguments(PARSE_ARGV 2 CTR_TEX3DS "" "OUTPUT" "INPUTS;OPTIONS")

    if (NOT CTR_TEX3DS_EXE)
        message(FATAL_ERROR "Could not find tex3ds: try installing tex3ds")
    endif()

    if(DEFINED CTR_TEX3DS_OUTPUT)
        get_filename_component(CTR_TEX3DS_OUTPUT "${CTR_TEX3DS_OUTPUT}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_BINARY_DIR}")
    else()
        set(CTR_TEX3DS_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${target}.t3x")
    endif()

    set(CTR_TEX3DS_ARGS -o "${CTR_TEX3DS_OUTPUT}")
    set(CTR_TEX3DS_DEPS "")

    string(TOUPPER "${kind}" kind)
    if(kind STREQUAL "IMAGE")
        # Nothing on purpose
    elseif(kind STREQUAL "CUBEMAP")
        list(APPEND CTR_TEX3DS_ARGS "--cubemap")
    elseif(kind STREQUAL "SKYBOX")
        list(APPEND CTR_TEX3DS_ARGS "--skybox")
    elseif(kind STREQUAL "ATLAS")
        list(APPEND CTR_TEX3DS_ARGS "--atlas")
    else()
        message(FATAL_ERROR "ctr_add_graphics_target: invalid mode: ${kind}")
    endif()

    list(LENGTH CTR_TEX3DS_INPUTS numinputs)
    if(numinputs LESS 1)
        message(FATAL_ERROR "ctr_add_graphics_target: must provide at least one input")
    endif()
    if(NOT kind STREQUAL "ATLAS" AND numinputs GREATER 1)
        message(FATAL_ERROR "ctr_add_graphics_target: multiple inputs only supported with atlas mode")
    endif()

    list(APPEND CTR_TEX3DS_ARGS ${CTR_TEX3DS_OPTIONS})
    foreach(input IN LISTS CTR_TEX3DS_INPUTS)
        dkp_resolve_file(infile "${input}")
        list(APPEND CTR_TEX3DS_ARGS "${infile}")

        if (TARGET "${input}")
            list(APPEND CTR_TEX3DS_DEPS ${input} "${infile}")
        else()
            list(APPEND CTR_TEX3DS_DEPS "${infile}")
        endif()
    endforeach()

    add_custom_command(
        OUTPUT "${CTR_TEX3DS_OUTPUT}"
        COMMAND "${CTR_TEX3DS_EXE}" ${CTR_TEX3DS_ARGS}
        DEPENDS ${CTR_TEX3DS_DEPS}
        COMMENT "Converting graphics target ${target}"
        VERBATIM
    )

    add_custom_target(${target} DEPENDS "${CTR_TEX3DS_OUTPUT}")
    dkp_set_target_file(${target} "${CTR_TEX3DS_OUTPUT}")
endfunction()
###