# Toy LLVM Backend Example For RISC-V

Yet another RISC-V LLVM Backend. This is a project for learning how LLVM backend works and what RISC-V architecture is
by reimplementing the official LLVM's RISC-V backend.

This example is inspired by:

- [toy-riscv-backend](https://github.com/rhysd/toy-riscv-backend)
- [llvm-toy](https://github.com/sunwayforever/llvm-toy)

## Build Environment preparation (DevContainer)

- Clone this repository:

```sh
mkdir -p ${HOME}/Desktop/dockerVolumn
cd ${HOME}/Desktop/dockerVolumn
git clone --recursive https://github.com/Alwaysproblem/Toy-llvm-backend
cd Toy-llvm-backend
```

- If you use devcontainer in vscode, please copy to the `llvm-project/llvm`

```bash
cp -R .devcontainer llvm-project/llvm/
```

- copy the recommand vscode setting to llvm

```bash
cp -R vscode llvm-project/llvm/.vscode
```

- Install qemu and install qemu riscv64

```bash
apt install --no-install-recommends qemu-user-static binfmt-support

update-binfmts --enable qemu-riscv32
update-binfmts --display qemu-riscv32
# update-binfmts --enable qemu-riscv64
# update-binfmts --display qemu-riscv64

sudo chmod a+x /usr/bin/qemu-*
```

- You can choose `Dev Containers: Open Folder in Containers` after pressing `F1` key.
- Choose the `llvm-project/llvm` folder.

## Testing Environment is Ready 

```bash
bash tools/apply_all_and_build.sh
./llvm-project/llvm/build/bin/llc --filetype=obj vscode/test/hello.ll
riscv32-unknown-linux-gnu-gcc -march=rv32g -Wl,--dynamic-linker /opt/gcc-riscv/sysroot/lib/ld-linux-riscv32-ilp32d.so.1 -mabi=ilp32d vscode/test/hello.o -o hello
export LD_LIBRARY_PATH="/opt/gcc-riscv/sysroot/lib/:${LD_LIBRARY_PATH}"
qemu-riscv32-static ./hello
```

# Expected Output

Please follow these steps to run the example serially.

## Ch1

```bash
bash tools/apply_patch.sh -p Ch1/0001-Adding-the-new-architecture-to-the-Triple-class.patch
bash tools/apply_patch.sh -p Ch1/0002-Targeting-Registration.patch
bash tools/apply_patch.sh -p Ch1/0003-Add-minimal-Toy-backend.patch
bash tools/apply_patch.sh -p Ch1/0004-Add-ToyMCCodeEmitter-and-asm-parser.patch
bash tools/apply_patch.sh -p Ch1/0005-Add-disassembler.patch
bash tools/build_target.sh -- llvm-mc

echo 'addi a0, a0, 15' | ./llvm-project/llvm/build/bin/llvm-mc --triple toy --show-encoding
    # .text
    # addi    a0, a0, 15                      # encoding: [0x13,0x05,0xf5,0x00]
echo '0x93,0x45,0xe6,0x00' | ./llvm-project/llvm/build/bin/llvm-mc --triple toy -disassemble
    # .text
    # xori    a1, a2, 14
```

For the binary encoding, you will find the notes on the `vscode/debug/disassembler_test.s` file.

## Ch2

### Adding Instruction Selection

```bash
bash tools/build_target.sh -p ./Ch2/0006-Adding-Instruction-Selection.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/addi.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
#         .cfi_startproc
# # %bb.0:
#         addi    t0, zero, 27
#         add     a0, a0, t0
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
```

### Store and Load

```bash
bash tools/build_target.sh -p ./Ch2/0007-store-and-load.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/load.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
#         .cfi_startproc
# # %bb.0:
#         lw      a0, 4(sp)
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/store.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
#         .cfi_startproc
# # %bb.0:
#         addi    t0, zero, 10
#         sw      t0, 4(sp)
#         addi    a0, zero, 0
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
```

## Ch3

```bash
bash tools/build_target.sh -p ./Ch3/0008-find-global-address.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/global_address.ll
#         .text
#         .file   "<stdin>"
#         .globl  useGlobals                      # -- Begin function useGlobals
#         .type   useGlobals,@function
# useGlobals:                             # @useGlobals
#         .cfi_startproc
# # %bb.0:
#         lui t0, %hi(intGlobal)
#         addi    t0, t0, %lo (intGlobal)
#         addi    t1, zero, 20
#         sw      t1, 0(t0)
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   useGlobals, .Lfunc_end0-useGlobals
#         .cfi_endproc
#                                         # -- End function
#         .type   intGlobal,@object               # @intGlobal
#         .data
#         .globl  intGlobal
#         .p2align        2, 0x0
# intGlobal:
#         .word   10                              # 0xa
#         .size   intGlobal, 4

#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0009-stack-management.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/prologue.ll
#         .text
#         .file   "<stdin>"
#         .globl  foo                             # -- Begin function foo
#         .type   foo,@function
# foo:                                    # @foo
#         .cfi_startproc
# # %bb.0:                                # %entry
#         addi    sp, sp, -16
#         addi    t0, zero, 1
#         sw      t0, 8(sp)
#         sw      t0, 12(sp)
#         sw      t0, 4(sp)
#         addi    sp, sp, 16
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   foo, .Lfunc_end0-foo
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/apply_patch.sh -p Ch3/0010-set-less-than-riscv.patch
bash tools/build_target.sh -p ./Ch3/0011-add-branch.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/branch.ll
#         .text
#         .file   "<stdin>"
#         .globl  foo                             # -- Begin function foo
#         .type   foo,@function
# foo:                                    # @foo
# # %bb.0:                                # %entry
#         addi    sp, sp, -16
#         sw      a0, 8(sp)
#         sw      a1, 4(sp)
#         lw      t0, 8(sp)
#         addi    t1, zero, 10
#         blt     t0, t1, .LBB0_2
#         jal     zero, .LBB0_1
# .LBB0_1:                                # %if.then
#         lw      t0, 8(sp)
#         lw      t1, 4(sp)
#         add     t0, t0, t1
#         sw      t0, 12(sp)
#         jal     zero, .LBB0_3
# .LBB0_2:                                # %if.end
#         lw      t0, 8(sp)
#         lw      t1, 4(sp)
#         sub     t0, t0, t1
#         sw      t0, 12(sp)
#         jal     zero, .LBB0_3
# .LBB0_3:                                # %return
#         lw      a0, 12(sp)
#         addi    sp, sp, 16
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   foo, .Lfunc_end0-foo
#                                         # -- End function
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
# # %bb.0:                                # %entry
#         addi    sp, sp, -32
#         sw      ra, 28(sp)
#         sw      s0, 24(sp)
#         addi    s0, zero, 0
#         sw      s0, 20(sp)
#         addi    t0, zero, 1
#         sw      t0, 16(sp)
#         addi    t0, zero, 2
#         sw      t0, 12(sp)
#         lw      a0, 16(sp)
#         lw      a1, 12(sp)
#         lui t0, %hi(foo)
#         addi    t0, t0, %lo (foo)
#         jalr    ra, t0, 0
#         sw      a0, 8(sp)
#         lw      a1, 8(sp)
#         lui t0, %hi(.L.str)
#         addi    a0, t0, %lo (.L.str)
#         lui t0, %hi(printf)
#         addi    t0, t0, %lo (printf)
#         jalr    ra, t0, 0
#         add     a0, zero, s0
#         lw      s0, 24(sp)
#         lw      ra, 28(sp)
#         addi    sp, sp, 32
#         jalr    zero, ra, 0
# .Lfunc_end1:
#         .size   main, .Lfunc_end1-main
#                                         # -- End function
#         .type   .L.str,@object                  # @.str
#         .section        .rodata.str1.1,"aMS",@progbits,1
# .L.str:
#         .asciz  "%d\n"
#         .size   .L.str, 4

#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0012-support-fp-inst.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/fp32.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
#         .cfi_startproc
# # %bb.0:
#         fdiv.s  ft0, fa0, fa1
#         fdiv.s  ft0, fa0, ft0
#         fdiv.s  fa0, fa0, ft0
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0013-support-fma.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/fma.ll
#         .text
#         .file   "<stdin>"
#         .section        .rodata.cst4,"aM",@progbits,4
#         .p2align        2, 0x0                          # -- Begin function foo
# .LCPI0_0:
#         .word   0x43660000                      # float 230
#         .text
#         .globl  foo
#         .type   foo,@function
# foo:                                    # @foo
#         .cfi_startproc
# # %bb.0:                                # %entry
#         addi    sp, sp, -16
#         lui t0, 268800
#         addi    t0, t0, 0
#         sw      t0, 8(sp)
#         lui t0, 266752
#         addi    t0, t0, 0
#         sw      t0, 12(sp)
#         lui t0, 276064
#         addi    t0, t0, 0
#         sw      t0, 4(sp)
#         lui t0, %hi(.LCPI0_0)
#         addi    t0, t0, %lo (.LCPI0_0)
#         flw     fa0, 0(t0)
#         addi    sp, sp, 16
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   foo, .Lfunc_end0-foo
#         .cfi_endproc
#                                         # -- End function
#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0014-support-store-in-asmparser.patch -- llvm-mc
./llvm-project/llvm/build/bin/llvm-mc -triple=toy vscode/debug/support-store-asmparser.s -show-encoding
#         .text
#         .file   "fma.ll"
#         .section        .rodata.cst4,"aM",@progbits,4
#         .p2align        2, 0x0
# .LCPI0_0:
#         .word   1130758144
#         .text
#         .globl  foo
#         .type   foo,@function
# foo:
#         .cfi_startproc
#         addi    sp, sp, -16                     # encoding: [0x13,0x01,0x01,0xff]
#         lui t0, 268800                          # encoding: [0xb7,0x02,0xa0,0x41]
#         addi    t0, t0, 0                       # encoding: [0x93,0x82,0x02,0x00]
#         sw      t0, 8(sp)                       # encoding: [0x23,0x24,0x51,0x00]
#         lui t0, 266752                          # encoding: [0xb7,0x02,0x20,0x41]
#         addi    t0, t0, 0                       # encoding: [0x93,0x82,0x02,0x00]
#         sw      t0, 12(sp)                      # encoding: [0x23,0x26,0x51,0x00]
#         lui t0, 276064                          # encoding: [0xb7,0x02,0x66,0x43]
#         addi    t0, t0, 0                       # encoding: [0x93,0x82,0x02,0x00]
#         sw      t0, 4(sp)                       # encoding: [0x23,0x22,0x51,0x00]
# getMachineOpValue from ToyMCExpr: %hi(.LCPI0_0)

#         lui t0, %hi(.LCPI0_0)                   # encoding: [0xb7,0x02,0x00,0x00]
# getMachineOpValue from ToyMCExpr: %lo(.LCPI0_0)

#         addi    t0, t0, %lo(.LCPI0_0)           # encoding: [0x93,0x82,0x02,0x00]
#         flw     fa0, 0(t0)                      # encoding: [0x07,0xa5,0x02,0x00]
#         addi    sp, sp, 16                      # encoding: [0x13,0x01,0x01,0x01]
#         jalr    zero, ra, 0                     # encoding: [0x67,0x80,0x00,0x00]
# .Lfunc_end0:
#         .size   foo, .Lfunc_end0-foo
#         .cfi_endproc
#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0015-write-to-obj.patch -- llc 
./llvm-project/llvm/build/bin/llc -filetype=obj ./vscode/test/hello.ll # you can find the `vscode/test/hello`
riscv32-unknown-linux-gnu-gcc -march=rv32g -Wl,--dynamic-linker /opt/gcc-riscv/sysroot/lib/ld-linux-riscv32-ilp32d.so.1 -mabi=ilp32d vscode/test/hello.o -o hello
export LD_LIBRARY_PATH="/opt/gcc-riscv/sysroot/lib/:${LD_LIBRARY_PATH}"
qemu-riscv32-static ./hello
# Hello, world
```

```bash
bash tools/build_target.sh -p ./Ch3/0016-add-intrinsic-function.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/intrinsic.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
# # %bb.0:                                # %entry
#         addi    sp, sp, -16
#         sw      ra, 12(sp)
#         addi    a1, sp, 0
#         lui t0, %hi(.L.str)
#         addi    a0, t0, %lo(.L.str)
#         lui t0, %hi(printf)
#         addi    t0, t0, %lo(printf)
#         jalr    ra, t0, 0
#         addi    a0, zero, 0
#         lw      ra, 12(sp)
#         addi    sp, sp, 16
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#                                         # -- End function
#         .type   .L.str,@object                  # @.str
#         .section        .rodata.str1.1,"aMS",@progbits,1
# .L.str:
#         .asciz  "%p\n"
#         .size   .L.str, 4

#         .section        ".note.GNU-stack","",@progbits
```

```bash
bash tools/build_target.sh -p ./Ch3/0017-add-intrinsic-function-with-LowerINTRINSIC_WO_C.patch -- llc
./llvm-project/llvm/build/bin/llc -filetype=asm < ./vscode/test/mod_intrinsic.ll
#         .text
#         .file   "<stdin>"
#         .globl  main                            # -- Begin function main
#         .type   main,@function
# main:                                   # @main
# # %bb.0:                                # %entry
#         addi    sp, sp, -16
#         sw      ra, 12(sp)
#         addi    t0, zero, 10
#         sw      t0, 8(sp)
#         addi    t0, zero, 3
#         sw      t0, 4(sp)
#         lw      t0, 8(sp)
#         lw      t1, 4(sp)
#         rem     a1, t0, t1
#         lui t0, %hi(.L.str)
#         addi    a0, t0, %lo(.L.str)
#         lui t0, %hi(printf)
#         addi    t0, t0, %lo(printf)
#         jalr    ra, t0, 0
#         addi    a0, zero, 0
#         lw      ra, 12(sp)
#         addi    sp, sp, 16
#         jalr    zero, ra, 0
# .Lfunc_end0:
#         .size   main, .Lfunc_end0-main
#                                         # -- End function
#         .type   .L.str,@object                  # @.str
#         .section        .rodata.str1.1,"aMS",@progbits,1
# .L.str:
#         .asciz  "%d\n"
#         .size   .L.str, 4

#         .section        ".note.GNU-stack","",@progbits
```
