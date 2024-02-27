Toy LLVM Backend Example For RISC-V
===========================

Yet another RISC-V LLVM Backend. This is a project for learning how LLVM backend works and what RISC-V architecture is
by reimplementing the official LLVM's RISC-V backend.

This example is inspired by:

- [toy-riscv-backend](https://github.com/rhysd/toy-riscv-backend)
- [llvm-toy](https://github.com/sunwayforever/llvm-toy)

## Getting started

### See through code within llvm directory

- create soft link in `llvm/.vscode`


  ```bash
  cd llvm-project/llvm/.vscode
  ln -s ../../../scripts_in_llvm/run_with_llc.sh run_with_llc.sh
  ```

### Clone this repository:

```sh
git clone --recursive https://github.com/Alwaysproblem/Toy-llvm-backend
```

### Build `riscv64-unknown-linux-gnu-gcc`

```bash
git clone https://github.com/riscv-collab/riscv-gnu-toolchain
cd /path/to/riscv-gnu-toolchain
configure --prefix=/opt/gcc-riscv --with-arch=rv64gc --with-abi=lp64d --enable-multilib
make linux
```

### Build Clang

```bash
cd /path/to/Toy-llvm-backend
bash tools/build_clang.sh
```

## Chapter 1 Registering the LLVM backend

[more details](https://llvm.org/docs/WritingAnLLVMBackend.html#preliminaries)

- build and run

  ```bash
  bash tools/build_llc.sh -p Ch1
  ./llvm-project/llvm/build/bin/llc --version
  # LLVM (http://llvm.org/):
  #   LLVM version x.x.x
  #   DEBUG build with assertions.
  #   Default target: 
  #   Host CPU: alderlake

  #   Registered Targets:
  #     toy - TOY Backend for riscv (32-bit) [experimental]
  ```


## [Target Machine & registration](https://llvm.org/docs/WritingAnLLVMBackend.html#target-machine)

- build and run

  ```bash
  bash tools/clean_llvm_branch.sh # Optional
  bash tools/build_llc.sh -p Ch2
  ./llvm-project/build_clang/bin/clang --target=riscv64-unknown-gnu -march=rv32g examples/arith.c -c -emit-llvm -O0 -o arith.bc
  ./llvm-project/llvm/build/bin/llc -debug -march=toy -filetype=asm arith.bc -o arith.S
  # Args: ./build/bin/llc -debug -march=toy -filetype=asm arith.bc -o arith.S 
  # llc: /root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/lib/CodeGen/LLVMTargetMachine.cpp:42: void llvm::LLVMTargetMachine::initAsmInfo(): Assertion 'MRI && "Unable to create reg info"' failed.
  # ...
  ```

### [Add the `LLVMInitializeToyTargetMC` function](https://pages.dogdog.run/toolchain/llvm_toy_riscv_backend.html#org000003f)

`LLVMInitializeToyTargetMC` sets callback functions, which are called during initAsm via TheTarget's createXXX methods to initialize TheTarget's `MRI`, `MII`, `STI`, `AsmInfo`, and others.

- **MRI (MCRegisterInfo):** Manages register numbers, names, and main information, primarily generated from `.td` files.
- **MII (MCInstrInfo):** Manages instruction encodings, names, and main information, primarily generated from `.td` files.
- **STI (MCSubtargetInfo):** Corresponds to subtarget information specified with `-mcpu`, `-mattr` during `llc` calls, using this info to initialize `STI`. Information is generated from `.td` files.
- **AsmInfo (MCAsmInfo):** Contains asm file format information, such as the `#` symbol for comments.

```bash
bash tools/clean_llvm_branch.sh # Optional
bash tools/build_llc.sh -p Ch3
# ./llvm-project/build_clang/bin/clang --target=riscv64-unknown-gnu -march=rv32g examples/arith.c -c -emit-llvm -O0 -o arith.bc
# ./llvm-project/llvm/build/bin/llc -debug -march=toy -filetype=asm arith.bc -o arith.S
# ; ModuleID = '/root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/.vscode/test/arith.bc'
# source_filename = "/root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/../../examples/arith.c"
# target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
# target triple = "riscv32-unknown-hurd-gnu"
# ...
# !0 = !{i32 1, !"wchar_size", i32 4}
# !1 = !{i32 1, !"target-abi", !"ilp32d"}
# !2 = !{i32 7, !"frame-pointer", i32 2}
# !3 = !{i32 1, !"SmallDataLimit", i32 8}
# !4 = !{!"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"}
# Args: /root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/build/bin/llc -debug -march=toy -filetype=asm /root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/.vscode/test/arith.bc -o /root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/.vscode/test/arith.S 
# llc: error: target does not support generation of this file type <- The error occurs because a SelectionDAGISel instance has not been specified for Toy. SelectionDAGISel is the entry point for the entire instruction selection (isel) process.
```

## [Register Set and Register Classes](https://llvm.org/docs/WritingAnLLVMBackend.html#register-set-and-register-classes)

you can apply the Ch3 patch to the llvm-project folder and see through the changes.

```bash
bash tools/apply_patch.sh -p Ch4
```

## Instruction Set
