function(bm_target_linker_file TARGET_NAME LINKER_FILE)
    target_link_options(${TARGET_NAME} PRIVATE -T ${LINKER_FILE})
endfunction()