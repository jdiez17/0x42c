#!/bin/bash

# programs
./dasm src/openf.dasm16 bin/openf.bin
dd if=bin/openf.bin ibs=1 skip=24576 of=bin/openf_trim.bin
./dasm src/echof.dasm16 bin/echof.bin
dd if=bin/echof.bin ibs=1 skip=24576 of=bin/echof_trim.bin
./dasm src/cleanf.dasm16 bin/cleanf.bin
dd if=bin/cleanf.bin ibs=1 skip=24576 of=bin/cleanf_trim.bin

./dasm src/0x42c.dasm16 bin/0x42c.bin
dd if=bin/0x42c.bin ibs=1 skip=8192 of=0x42c_trim.bin
./dasm src/kernel.dasm16 kernel.bin
cp kernel.bin /mnt/dcpu
