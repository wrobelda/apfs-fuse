# Inventory tests

Run these commands from the repository root after installing the normal build dependencies:

```
cmake -S . -B build -DBUILD_TESTING=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build
ctest --test-dir build --output-on-failure
```

CMake 4 needs `CMAKE_POLICY_VERSION_MINIMUM` because the project declares an older minimum version.
The tests use C++ and CMake without additional dependencies.
Set `BUILD_TESTING=OFF` to exclude the test executables from a build.

`Inventory.cpp` creates synthetic metadata in memory and writes test images under the build directory.
The images contain no private disk data, file contents, credentials, or volume keys.
They provide metadata for inventory tests, not complete filesystems for mounting.

The tests cover unavailable B-tree roots, stale iterators, unreadable child nodes, truncated snapshot records, and invalid snapshot names.
They also cover empty snapshot trees and failures after the first snapshot.
