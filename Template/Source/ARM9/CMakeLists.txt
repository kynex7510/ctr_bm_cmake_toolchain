# We are linking with libn3ds for ARM9.
include(BM/N3DS9)

# Add a new executable.
add_executable(MyApp9 Main.c)
target_link_libraries(MyApp9 PRIVATE n3ds9)

# Use the default linker file provided by the toolchain.
bm_target_linker_file(MyApp9 ${CTR_BM_TOOLCHAIN_ROOT}/Linker/Default9.ld)

# Generate ARM9 binary data.
add_firm_binary(MyApp9_bin MyApp9)