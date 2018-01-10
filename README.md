# Mininal example code to boot a cortex-m4 on the simulated nucleo platform
Don't forget to pull from the rabbits repos (`./repos pull`) before doing what is said below.

To compile this, make sure you have the `binutils-arm-none-eabi` package installed (debian), so that everything is in your path.

Then, build the binaries using `make`.
This produces a `.bin` file that is to be used to feed QEMU, and a `.elf` file that has to be given as argument to `gdb`.

The `vectors.s` file contains the whole interrupt service routines entries as given in STMicro documentation (extracted from the pdf) but none of them but the reset do something else than a self loop.
The reset handler does nothing as of today, and the C entry point is `__start` function.
If necessary, you can add your own stuff in the reset handler prior to calling `__start`, and have `__start` call whatever you think necessary.

To launch a simulation in debug mode, run in one terminal:
```
./nucleo-f401re.sh -gdb-server 1234 -nographic -components.flash.file-blob ../softs/bare_tests/test.bin
```
and in an other terminal:
```
arm-none-eabi-gdb test.elf -ex "tar rem :1234"
```

Now add your own test to this.
