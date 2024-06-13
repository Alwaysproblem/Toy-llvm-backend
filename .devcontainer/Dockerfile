FROM alwaysproblem/fastdev-u2204:zsh

RUN apt update -y && \
    apt install -y wget curl git gpg htop python3 && \
    apt install -y g++-12 gcc-12 cmake ninja-build && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 20 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 20
