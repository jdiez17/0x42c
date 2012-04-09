#!/bin/bash

./dasm 0x42c.dasm16 0x42c.bin
dd if=0x42c.bin ibs=1 skip=8192 of=0x42c_trim.bin
./dasm bootloader.dasm16 bootloader.bin
#cp bootloader.bin /mnt/dcpu
