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
