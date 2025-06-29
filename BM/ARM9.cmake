include(BM/_Common)

set(CMAKE_C_FLAGS "${ARM9_FLAGS} -mword-relocations -ffunction-sections")
set(CMAKE_CXX_FLAGS "${ARM9_FLAGS} -fno-rtti -fno-exceptions -mword-relocations -ffunction-sections")
set(CMAKE_ASM_FLAGS "${ARM9_FLAGS} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS ${ARM9_LINKER_FLAGS})
set(CTR_BAREMETAL_ARM9 ON)