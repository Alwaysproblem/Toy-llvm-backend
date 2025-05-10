#!/bin/bash

WORKSPACE=`pwd`

if [[ -f "/usr/bin/git" ]]; then
  WORKSPACE=`git rev-parse --show-toplevel`
  cd ${WORKSPACE}
fi

bash ${WORKSPACE}/tools/apply_patch.sh -p Ch1/0001-Adding-the-new-architecture-to-the-Triple-class.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch1/0002-Targeting-Registration.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch1/0003-Add-minimal-Toy-backend.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch1/0004-Add-ToyMCCodeEmitter-and-asm-parser.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch1/0005-Add-disassembler.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch2/0006-Adding-Instruction-Selection.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch2/0007-store-and-load.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0008-find-global-address.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0009-stack-management.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0010-set-less-than-riscv.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0011-add-branch.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0012-support-fp-inst.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0013-support-fma.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0014-support-store-in-asmparser.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0015-write-to-obj.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0016-add-intrinsic-function.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0017-add-intrinsic-function-with-LowerINTRINSIC_WO_C.patch
bash ${WORKSPACE}/tools/apply_patch.sh -p Ch3/0018-fixup-for-branch.patch
bash ${WORKSPACE}/tools/build_llc.sh

./llvm-project/llvm/build/bin/llc vscode/test/hello.ll
