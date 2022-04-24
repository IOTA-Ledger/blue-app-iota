FROM ubuntu:latest AS build-app

ENV DEVICE=nanos

# switch to non-interactive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libusb-dev libusb-1.0-0-dev libudev-dev cmake build-essential qemu-user-static python3-pyqt5 \
    python3-construct python3-jsonschema python3-mnemonic python3-pyelftools python3-flask \
    python3-flask-restful gcc-arm-linux-gnueabihf libc6-dev-armhf-cross gdb-multiarch pkg-config \
    libssl-dev protobuf-compiler lld-7 wget tar xz-utils ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

WORKDIR /opt

RUN mkdir gcc
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -O- | tar -xj -C gcc --strip-components 1

RUN mkdir clang
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/clang+llvm-12.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz -O- | tar -xJ -C clang --strip-components 1

# build blue loader
RUN mkdir -p /opt/ledger
WORKDIR /opt/ledger
RUN git clone https://github.com/LedgerHQ/blue-loader-python
RUN git clone https://github.com/LedgerHQ/speculos

WORKDIR /opt/ledger/blue-loader-python
RUN python3.8 setup.py install

# build speculos simulator
WORKDIR /opt/ledger/speculos
RUN cmake -Bbuild -H. && make -C build/ 

WORKDIR /root/git/

RUN echo '#!/bin/bash\n' \
    'export DEVICE=nanos\n' \
    'export BOLOS_SDK=/root/git/app/dev/sdk/nanos-secure-sdk\n' \
    'unset BOLOS_ENV\n' \
    'export CLANGPATH=/opt/clang/bin/\n' \
    'export GCCPATH=/opt/gcc/bin/\n' \
    'echo nanos > device.txt\n' > env_nanos.sh

RUN sed 's|nanos|nanox|g' env_nanos.sh > env_nanox.sh
RUN sed 's|nanos|nanosplus|g' env_nanos.sh > env_nanosplus.sh

EXPOSE 9999
