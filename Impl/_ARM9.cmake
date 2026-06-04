if (CTR_BM_ARM11)
    message(FATAL_ERROR "Attempted to enable ARM9 compilation with ARM11 already enabled")
endif()

set(CMAKE_C_FLAGS "${CTR_BM_ARM9_FLAGS} -mword-relocations -ffunction-sections")
set(CMAKE_CXX_FLAGS "${CTR_BM_ARM9_FLAGS} -fno-rtti -fno-exceptions -mword-relocations -ffunction-sections")
set(CMAKE_ASM_FLAGS "${CTR_BM_ARM9_FLAGS} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS ${CTR_BM_ARM9_LINKER_FLAGS})
set(CTR_BM_ARM9 ON)