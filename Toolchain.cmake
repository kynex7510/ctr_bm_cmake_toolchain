cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

# Check for devkitPro.
if (NOT DEVKITPRO)
    if (NOT DEFINED ENV{DEVKITPRO})
        message(FATAL_ERROR "DEVKITPRO variable not set!")
    else()
        set(DEVKITPRO $ENV{DEVKITPRO})
    endif()
endif()

# Check for toolchain root.
if (NOT CTR_BM_TOOLCHAIN_ROOT)
    if (NOT DEFINED ENV{CTR_BM_TOOLCHAIN_ROOT})
        message(FATAL_ERROR "CTR_BM_TOOLCHAIN_ROOT variable not set!")
    else()
        set(CTR_BM_TOOLCHAIN_ROOT $ENV{CTR_BM_TOOLCHAIN_ROOT})
    endif()
endif()

# Set system variables.
set(CMAKE_SYSTEM_NAME Generic-ELF)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR armv6k)

# Setup devkitARM.
include(${DEVKITPRO}/cmake/devkitARM.cmake)
include(${DEVKITPRO}/cmake/dkp-embedded-binary.cmake)

find_program(CTR_PICASSO_EXE NAMES picasso HINTS "${DEVKITPRO}/tools/bin")
find_program(CTR_TEX3DS_EXE NAMES tex3ds HINTS "${DEVKITPRO}/tools/bin")

# Set baremetal flag.
set(CTR_BM ON)

# Set default arch flags.
set(CTR_BM_ARM9_FLAGS "-march=armv5te -mtune=arm946e-s -mfloat-abi=soft -mtp=soft -marm -mthumb-interwork -masm-syntax-unified -D__ARM9__ -D__3DS__")
set(CTR_BM_ARM11_FLAGS "-march=armv6k+vfpv2 -mtune=mpcore -mfloat-abi=hard -mtp=soft -marm -mthumb-interwork -masm-syntax-unified -D__ARM11__ -D__3DS__")

# Set default linker flags.
# TODO: map
set(CTR_BM_ARM9_LINKER_FLAGS "${CTR_BM_ARM9_FLAGS} -Wl,-d -Wl,--use-blx -Wl,--gc-sections -nostartfiles")
set(CTR_BM_ARM11_LINKER_FLAGS "${CTR_BM_ARM11_FLAGS} -Wl,-d -Wl,--use-blx -Wl,--gc-sections -nostartfiles")

# Include FIRM stuff.
include(${CTR_BM_TOOLCHAIN_ROOT}/Impl/_FIRM.cmake)

# Define wrappers.
macro(ctr_bm_enable_arm9)
    include(${CTR_BM_TOOLCHAIN_ROOT}/Impl/_ARM9.cmake)
endmacro()

macro(ctr_bm_enable_arm11)
    include(${CTR_BM_TOOLCHAIN_ROOT}/Impl/_ARM11.cmake)
endmacro()

function(ctr_bm_link_libn3ds)
    if (ARGC LESS 1)
        message(FATAL_ERROR "ctr_bm_link_libn3ds: No target specified")
    endif()

    if (ARGC GREATER 1)
        set(N3DS_VISIBILITY ${ARGV1})
    else()
        set(N3DS_VISIBILITY PRIVATE)
    endif()

    if (CTR_BM_ARM9)
        include(${CTR_BM_TOOLCHAIN_ROOT}/Impl/_N3DS9.cmake)
        target_link_libraries(${ARGV0} ${N3DS_VISIBILITY} n3ds9)
    elseif(CTR_BM_ARM11)
        include(${CTR_BM_TOOLCHAIN_ROOT}/Impl/_N3DS11.cmake)
        target_link_libraries(${ARGV0} ${N3DS_VISIBILITY} n3ds11)
    else()
        message(FATAL_ERROR "ctr_bm_link_libn3ds: No target CPU specified, call ctr_bm_enable_arm9() or ctr_bm_enable_arm11() to use libn3ds")
    endif()
endfunction()