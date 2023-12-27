Toy LLVM Backend Example For RISC-V
===========================

Yet another RISC-V LLVM Backend. This is a project for learning how LLVM backend works and what RISC-V architecture is
by reimplementing the official LLVM's RISC-V backend.

This example is inspired by:

- [toy-riscv-backend](https://github.com/rhysd/toy-riscv-backend)
- [llvm-toy](https://github.com/sunwayforever/llvm-toy)

## Getting started

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


## Target Machine & registration

- build and run

  ```bash
  bash tools/clean_llvm_branch.sh # Optional
  bash tools/build_llc.sh -p Ch2
  ./llvm-project/build_clang/bin/clang --target=riscv64-unknown-gnu -march=rv32g examples/arith.cpp -c -emit-llvm -O0 -o arith.bc
  ./llvm-project/llvm/build/bin/llc -debug -march=toy -filetype=asm arith.bc -o arith.S
  # Args: ./build/bin/llc -debug -march=toy -filetype=asm arith.bc -o arith.S 
  # llc: /root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/lib/CodeGen/LLVMTargetMachine.cpp:42: void llvm::LLVMTargetMachine::initAsmInfo(): Assertion 'MRI && "Unable to create reg info"' failed.
  # ...
  ```

