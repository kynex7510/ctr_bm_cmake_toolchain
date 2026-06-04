if (CTR_BM_ARM9)
    message(FATAL_ERROR "Attempted to enable ARM11 compilation with ARM9 already enabled")
endif()

include(${CTR_BM_TOOLCHAIN_ROOT}/BM/_DKA.cmake)

set(CMAKE_C_FLAGS "${CTR_BM_ARM11_FLAGS} -mword-relocations -ffunction-sections")
set(CMAKE_CXX_FLAGS "${CTR_BM_ARM11_FLAGS} -fno-rtti -fno-exceptions -mword-relocations -ffunction-sections")
set(CMAKE_ASM_FLAGS "${CTR_BM_ARM11_FLAGS} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS ${CTR_BM_ARM11_LINKER_FLAGS})
set(CTR_BM_ARM11 ON)