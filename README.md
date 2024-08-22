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
git clone -b llvm-toy --recursive https://github.com/Alwaysproblem/Toy-llvm-backend
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
