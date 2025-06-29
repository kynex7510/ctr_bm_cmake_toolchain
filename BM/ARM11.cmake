include(BM/_Common)

set(CMAKE_C_FLAGS "${ARM11_FLAGS} -mword-relocations -ffunction-sections")
set(CMAKE_CXX_FLAGS "${ARM11_FLAGS} -fno-rtti -fno-exceptions -mword-relocations -ffunction-sections")
set(CMAKE_ASM_FLAGS "${ARM11_FLAGS} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS ${ARM11_LINKER_FLAGS})
set(CTR_BAREMETAL_ARM11 ON)