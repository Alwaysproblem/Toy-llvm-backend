#!/bin/bash

riscv32-unknown-linux-gnu-gcc -march=rv32g -mabi=ilp32d call_with_multi_args_obj.o -o call_with_multi_args_obj
qemu-riscv32-static ./call_with_multi_args_obj
