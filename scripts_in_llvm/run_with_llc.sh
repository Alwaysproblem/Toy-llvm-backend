#!/bin/bash

EXAMPLE_NAME="arith"
function usage
{
    echo "Usage: $0 [-e | -S]"
    echo ""
    echo "  -e | --example-name  specify the example name of examples dir."
    echo "  -S                  assemble the example to .s file."
}

while test $# -gt 0
do
   case "$1" in
        -e | --example-name)
            shift
            EXAMPLE_NAME=$1;
            ;;
        -S)
            shift
            _ASSEMBLE=1;
            ;;
        -h | -H | --help)
            usage
            exit 1
            ;;
        *) echo "ERROR: bad argument $1"
            usage
            exit 2
            ;;
    esac
    shift
done

LLVM_WORKSPACK=`pwd`

mkdir -p ${LLVM_WORKSPACK}/.vscode/test/

if [[ -z ${_ASSEMBLE} ]]; then
    ${LLVM_WORKSPACK}/../build_clang/bin/clang --target=riscv64-unknown-gnu -march=rv32g ${LLVM_WORKSPACK}/../../examples/${EXAMPLE_NAME}.c -c -emit-llvm -O0 -o ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.bc
    ${LLVM_WORKSPACK}/../build_clang/bin/llvm-dis ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.bc -o ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.ll
    cat ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.ll
    ${WORKSPACK}/build/bin/llc -debug -march=toy -filetype=asm ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.bc -o ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.S 
else
    ${LLVM_WORKSPACK}/../build_clang/bin/clang --target=riscv64-unknown-gnu -march=rv32g ${LLVM_WORKSPACK}/../../examples/${EXAMPLE_NAME}.c -c -emit-llvm -O0 -o ${LLVM_WORKSPACK}/.vscode/test/${EXAMPLE_NAME}.s -S
fi
