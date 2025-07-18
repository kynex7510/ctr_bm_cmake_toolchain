cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

# libn3ds requires C23, CXX, ASM to be enabled.
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
project(MyApp C CXX ASM)

# Include FIRM building support.
include(BM/FIRM)

# Compile app code.
add_subdirectory(Source)

# Set ARM9 informations.
set(ARM9_TARGET MyApp9_bin)
set(ARM9_LOAD_ADDRESS 0x08000040) # Where to load the address in memory, should match the linker script.
set(ARM9_ENTRYPOINT 0x08000040) # Entrypoint, should match the linker script.
set(ARM9_COPY_METHOD NDMA) # Binary data copy method (NDMA, XDMA, memcpy).

# Set ARM11 informations.
set(ARM11_TARGET MyApp11_bin)
set(ARM11_LOAD_ADDRESS 0x1FF89000)
set(ARM11_ENTRYPOINT 0x1FF89034)
set(ARM11_COPY_METHOD XDMA)

# Make FIRM.
make_firm(MyApp
    ARM9 ${ARM9_TARGET} ${ARM9_LOAD_ADDRESS} ${ARM9_ENTRYPOINT} ${ARM9_COPY_METHOD}
    ARM11 ${ARM11_TARGET} ${ARM11_LOAD_ADDRESS} ${ARM11_ENTRYPOINT} ${ARM11_COPY_METHOD}
)