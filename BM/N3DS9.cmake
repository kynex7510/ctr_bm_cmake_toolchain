include(BM/_N3DSChecks)
include(BM/ARM9)

set(LIBN3DS_SOURCE_PATHS
    ${LIBN3DS_ROOT}/source
    ${LIBN3DS_ROOT}/source/drivers/mmc
    ${LIBN3DS_ROOT}/source/drivers
    ${LIBN3DS_ROOT}/source/arm9
    ${LIBN3DS_ROOT}/source/arm9/drivers
    ${LIBN3DS_ROOT}/libraries/fatfs/source
    ${LIBN3DS_ROOT}/source/arm9/fatfs
)

set(LIBN3DS_SOURCES)

foreach(DIR IN LISTS LIBN3DS_SOURCE_PATHS)
    foreach(EXT c cpp s)
        file(GLOB TMP_FILES CONFIGURE_DEPENDS "${DIR}/*.${EXT}")
        list(APPEND LIBN3DS_SOURCES ${TMP_FILES})
    endforeach()
endforeach()

set(LIBN3DS_INCLUDE_PATHS
    ${LIBN3DS_ROOT}/include
    ${LIBN3DS_ROOT}/libraries
    ${LIBN3DS_ROOT}/source/arm9/fatfs
)

add_library(n3ds9 OBJECT ${LIBN3DS_SOURCES})
target_include_directories(n3ds9 PUBLIC ${LIBN3DS_INCLUDE_PATHS})