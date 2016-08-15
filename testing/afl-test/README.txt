Testing AFL on simple binary

It is recommended to run modify_core_pattern.sh as root before start testing

make qemu-test: test the afl qemu instrumentation (for binary without source code)

make gcc-test: test the afl-gcc instrumentation (require source code)

make clang-test: test the afl-clang-fast instrumentation (require source code)


