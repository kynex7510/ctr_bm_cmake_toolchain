# We are linking with libn3ds for ARM11.
include(BM/N3DS11)

# Add a new executable.
add_executable(MyApp11 Main.c)
target_link_libraries(MyApp11 PRIVATE n3ds11)

# Use the default linker file provided by the toolchain.
bm_target_linker_file(MyApp11 ${CTR_BM_TOOLCHAIN_ROOT}/Linker/Default11.ld)

# Generate ARM11 binary data.
add_firm_binary(MyApp11 MyApp11_bin)