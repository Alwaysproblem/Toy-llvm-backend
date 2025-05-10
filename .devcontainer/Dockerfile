FROM alwaysproblem/fastdev-u2204:zsh

RUN apt update -y && \
    apt install -y wget gdb gpg htop autoconf automake \
        autotools-dev curl python3 python3-pip \
        libmpc-dev libmpfr-dev libgmp-dev gawk \
        build-essential bison flex texinfo gperf \
        libtool patchutils bc zlib1g-dev \
        libexpat-dev ninja-build git \
    cmake libglib2.0-dev libslirp-dev && \
    apt install -y g++-12 gcc-12 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 20 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 20

WORKDIR /root/Download
RUN git clone --recursive --depth=1 https://github.com/riscv-collab/riscv-gnu-toolchain \
    && cd riscv-gnu-toolchain \
    && ./configure --prefix=/opt/gcc-riscv --with-arch=rv32gc --with-abi=ilp32d \
    && make linux -j 16 \
    && rm -rf ../riscv-gnu-toolchain \
    && echo "export PATH=/opt/gcc-riscv/bin/:\${PATH}" >> ~/.zshrc

WORKDIR /root/Desktop
