# Template

```sh
cmake -B Build -DCMAKE_TOOLCHAIN_FILE="$CTR_BM_TOOLCHAIN_ROOT/Toolchain.cmake" -DCMAKE_BUILD_TYPE=Release
cmake --build Build --config Release
```