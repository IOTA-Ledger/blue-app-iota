#!/usr/bin/env bash

NANOS_SDK_VERSION=master # use tag, when available
BLUE_SDK_VERSION=blue-r21.1

export BOLOS_ENV=`realpath ../bolos-devenv`
DIR_ARM_GCC=${BOLOS_ENV}/gcc-arm-none-eabi-5_3-2016q1/
DIR_CLANG=${BOLOS_ENV}/clang-arm-fropi/
DIR_NANOS_SDK=${BOLOS_ENV}/nanos-sdk/
DIR_BLUE_SDK=${BOLOS_ENV}/blues-sdk/

mkdir -p ${BOLOS_ENV}

apt-get update && apt-get install -y \
  gcc-multilib \
  git \
  make \
  python-minimal \
  python-pil \
  wget

echo "Downloading \"gcc-arm-none-eabi-5_3-2016q1\""
wget -N https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 -P ${BOLOS_ENV}/
echo "Unzipping \"gcc-arm-none-eabi-5_3-2016q1\""
tar xf ${BOLOS_ENV}/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 -C ${BOLOS_ENV}/

echo "Downloading \"clang+llvm-4.0.0\""
wget -N http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz -P ${BOLOS_ENV}/

echo "Unzipping \"clang+llvm-4.0.0\""
tar xf ${BOLOS_ENV}/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz -C ${BOLOS_ENV}/
mv ${BOLOS_ENV}/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10 ${BOLOS_ENV}/clang-arm-fropi

echo "Downloading nanos-secure-sdk"
git clone --depth=1 -b ${NANOS_SDK_VERSION} https://github.com/LedgerHQ/nanos-secure-sdk.git ${DIR_NANOS_SDK}

echo "Building nanos-app"
export BOLOS_SDK=${DIR_NANOS_SDK}
mkdir -p bin/
make clean && make
mv bin/ nanos-bin/
chmod -R 777 nanos-bin/

echo "Downloading blue-secure-sdk"
git clone --depth=1 -b ${BLUE_SDK_VERSION} https://github.com/LedgerHQ/blue-secure-sdk.git ${DIR_BLUE_SDK}

echo "Building blue-app"
export BOLOS_SDK=${DIR_BLUE_SDK}
mkdir -p bin/
make clean && make
mv bin/ blue-bin/
chmod -R 777 blue-bin/
