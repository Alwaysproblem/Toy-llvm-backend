#!/bin/bash

APPLY_PATCH=""

function usage
{
    echo "Usage: $0 [--apply-patch]"
    echo ""
    echo "  --apply-patch  apply the patch in directory to the LLVM source code"
}

function apply_patch {
  local apply_dir=$1
  if [[ ${apply_dir} != "" ]]; then
      echo "Applying patch to LLVM source code"
      cd llvm-project/
      git apply ../${apply_dir}/llvm.patch
  fi
}

function apply_patch_main {
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
  apply_patch ${APPLY_PATCH}

}

RUNNING="$(basename $0)"

if [[ "$RUNNING" == "apply_patch.sh" ]]
then
  apply_patch_main "$@"
fi
