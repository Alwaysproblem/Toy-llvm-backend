#!/bin/bash

cd ./llvm-project/llvm
rm -rf ../build_clang
mkdir ../build_clang
pushd ../build_clang
cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_INSTALL_PREFIX="/opt/llvm-riscv" \
      -DLLVM_BUILD_TESTS=False \
      -DDEFAULT_SYSROOT="/opt/gcc-riscv/sysroot/" \
      -DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-linux-gnu" \
      -DLLVM_TARGETS_TO_BUILD=RISCV -DLLVM_ENABLE_PROJECTS="clang;llvm" \
      -DLLVM_OPTIMIZED_TABLEGEN=On -DLLVM_PARALLEL_LINK_JOBS=10 -DLLVM_BUILD_TOOLS=ON -G "Ninja" ../llvm
ninja
popd
