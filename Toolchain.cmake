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

# Set baremetal flag.
set(CTR_BAREMETAL ON)

# Set module path.
list(APPEND CMAKE_MODULE_PATH "${CTR_BM_TOOLCHAIN_ROOT}")

# Set system variables.
set(CMAKE_SYSTEM_NAME Generic-ELF)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR armv6k)

# Setup devkitARM.
include(${DEVKITPRO}/cmake/devkitARM.cmake)

# Set default arch flags.
set(ARM9_FLAGS "-march=armv5te -mtune=arm946e-s -mfloat-abi=soft -mtp=soft -marm -mthumb-interwork -masm-syntax-unified -D__ARM9__ -D__3DS__")
set(ARM11_FLAGS "-march=armv6k+vfpv2 -mtune=mpcore -mfloat-abi=hard -mtp=soft -marm -mthumb-interwork -masm-syntax-unified -D__ARM11__ -D__3DS__")

# Set default linker flags.
# TODO: map
set(ARM9_LINKER_FLAGS "${ARM9_FLAGS} -Wl,-d -Wl,--use-blx -Wl,--gc-sections -nostartfiles")
set(ARM11_LINKER_FLAGS "${ARM11_FLAGS} -Wl,-d -Wl,--use-blx -Wl,--gc-sections -nostartfiles")