#!/bin/bash

# programs
./dasm openf.dasm16 openf.bin
dd if=openf.bin ibs=1 skip=24576 of=openf_trim.bin
./dasm echof.dasm16 echof.bin
dd if=echof.bin ibs=1 skip=24576 of=echof_trim.bin
./dasm cleanf.dasm16 cleanf.bin
dd if=cleanf.bin ibs=1 skip=24576 of=cleanf_trim.bin

./dasm 0x42c.dasm16 0x42c.bin
dd if=0x42c.bin ibs=1 skip=8192 of=0x42c_trim.bin
./dasm kernel.dasm16 kernel.bin
cp kernel.bin /mnt/dcpu
