#!/bin/bash

cd llvm-project/
git checkout -q -- .
git clean -q -f -d
cd -
