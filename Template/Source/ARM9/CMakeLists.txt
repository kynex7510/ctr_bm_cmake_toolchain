# Enable ARM9 compilation.
ctr_bm_enable_arm9()

# Add a new executable and link to libn3ds.
add_executable(MyApp9 Main.c)
ctr_bm_link_libn3ds(MyApp9)

# Use the default linker file provided by the toolchain.
target_link_options(MyApp9 PRIVATE -T ${CTR_BM_TOOLCHAIN_ROOT}/Linker/Default9.ld)

# Generate ARM9 binary data.
ctr_bm_add_firm_binary(MyApp9_bin MyApp9)