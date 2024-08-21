#!/bin/bash

WORKSPACE=$PWD

if [[ -f "/usr/bin/git" ]]; then
  WORKSPACE=`git rev-parse --show-toplevel`
  cd ${WORKSPACE}
fi

source ${WORKSPACE}/tools/apply_patch.sh
APPLY_PATCH=""

function usage
{
    echo "Usage: $0 [--apply-patch]"
    echo ""
    echo "  --apply-patch  apply the patch in directory to the LLVM source code"
}

while test $# -gt 0
do
   case "$1" in
        -p | --apply-patch)
            shift
            APPLY_PATCH=$1;
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

if [ ! -z "APPLY_PATCH" ]; then
    apply_patch ${APPLY_PATCH}
fi

cd ${WORKSPACE}/llvm-project/llvm
rm -rf build
mkdir ./build

cmake --no-warn-unused-cli \
  -Wno-dev \
  -DCMAKE_BUILD_TYPE=Debug \
  -DLLVM_TARGETS_TO_BUILD=Toy \
  -DLLVM_PARALLEL_LINK_JOBS=4 \
  -DCMAKE_BUILD_TYPE:STRING=Debug \
  -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
  -DCMAKE_C_COMPILER:FILEPATH=$(which gcc) \
  -DCMAKE_CXX_COMPILER:FILEPATH=$(which g++) \
  -S${WORKSPACE}/llvm-project/llvm \
  -B${WORKSPACE}/llvm-project/llvm/build \
  -G Ninja

cmake --build ${WORKSPACE}/llvm-project/llvm/build --config Debug --target llc
