RUN_AFL=afl-fuzz -i ./in -o ./out

# test afl-qemu trace for binary only
qemu-test:
	gcc -o buf buf.c &&\
	$(RUN_AFL) -Q ./buf

# test afl-gcc instrumentation fuzzing
gcc-test:
	afl-gcc -o buf-gcc buf.c &&\
	$(RUN_AFL) ./buf-gcc

# test afl-clang-fast instrumentation fuzzing
clang-test:
	afl-clang-fast -o buf-clang buf.c &&\
	$(RUN_AFL) ./buf-clang

