# Enable ARM11 compilation.
ctr_bm_enable_arm11()

# Add a new executable and link to libn3ds.
add_executable(MyApp11 Main.c)
ctr_bm_link_libn3ds(MyApp11)

# Use the default linker file provided by the toolchain.
target_link_options(MyApp11 PRIVATE -T ${CTR_BM_TOOLCHAIN_ROOT}/Linker/Default11.ld)

# Generate ARM11 binary data.
ctr_bm_add_firm_binary(MyApp11_bin MyApp11)