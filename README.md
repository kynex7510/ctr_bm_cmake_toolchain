# CMake Baremetal Toolchain for 3DS

This is a CMake toolchain for compiling baremetal (FIRM) 3DS homebrew with libn3ds.

## Setup

- [devkitARM](https://devkitpro.org/wiki/devkitARM) is required.
- [firmtool](https://github.com/TuxSH/firmtool) is required.

1. Clone this repo and [libn3ds](https://github.com/profi200/libn3ds) somewhere.
2. Set `CTR_BM_TOOLCHAIN_ROOT` to the root of the repo.
3. Set `LIBN3DS_ROOT` to the root of libn3ds.

## How-to

Pass `-DCMAKE_TOOLCHAIN_FILE="$CTR_BM_TOOLCHAIN_ROOT/Toolchain.cmake"` for enabling baremetal compilation. Check the [template](Template/CMakeLists.txt) for usage instructions.