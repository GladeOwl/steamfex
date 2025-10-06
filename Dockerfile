FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y update && apt -y upgrade
RUN apt install -y \
    git \
    cmake \
    ninja-build \
    pkgconf \
    ccache \
    clang \
    llvm \
    lld \
    binfmt-support \
    libssl-dev \
    python3-setuptools \
    g++-x86-64-linux-gnu \
    nasm \
    python3-clang \
    libgcc-12-dev-i386-cross \
    libgcc-12-dev-amd64-cross \
    libstdc++-12-dev-i386-cross \
    libstdc++-12-dev-amd64-cross \
    squashfs-tools \
    squashfuse \
    qtdeclarative5-dev \
    qml-module-qtquick-controls \
    qml-module-qtquick-controls2 \
    qml-module-qtquick-dialogs \
    curl \
    python3 \
    software-properties-common \
    sudo \
    wget \
    fuse3 \
    expect

FROM base AS fexinstall

RUN useradd -m -s /bin/bash fex
RUN echo "fex ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER fex

WORKDIR /home/fex

RUN git clone --recurse-submodules https://github.com/FEX-Emu/FEX.git && \
    cd FEX && \
    mkdir Build && \
    cd Build && \
    CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DENABLE_LTO=True -DBUILD_TESTS=False -DENABLE_ASSERTIONS=False -G Ninja .. && \
    ninja

WORKDIR /home/fex/FEX/Build

RUN sudo ninja install

FROM fexinstall AS fexrootfs

USER root

RUN useradd -m -s /bin/bash steam
RUN echo "steam ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER steam

WORKDIR /home/steam/.fex-emu/RootFS
RUN sudo wget https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-03-04/Ubuntu_24_04.sqsh

WORKDIR /home/steam/.fex-emu
RUN echo '{"Config":{"RootFS":"Ubuntu_24_04.sqsh"}}' > Config.json

FROM fexrootfs AS steam

WORKDIR /home/steam/Steam

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
ENTRYPOINT FEXBash ./steamcmd.sh