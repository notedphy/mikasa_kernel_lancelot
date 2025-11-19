#!/bin/bash
# copy right by zetaxbyte
# you can rich me on telegram t.me/@zetaxbyte
# flags

DEFCONFIG="lancelot_defconfig"

# you can set you name or host name(optional)

export KBUILD_BUILD_USER="t.me@/notedphy"
export KBUILD_BUILD_HOST="mikasa"

# do not modify TC_DIR and export PATCH it's been including with the proton-clang dir

TC_DIR="/root/clan"

export PATH="$TC_DIR/bin:$PATH"

mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

make -j$(nproc --all) O=out ARCH=arm64 CC=clang AR=llvm-ar NM=llvm-nm STRIP=llvm-strip CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- 2>&1 | tee log.txt

if [ -f out/arch/arm64/boot/Image ] ; then
    echo -e "$cyan===========================\033[0m"
    echo -e "$cyan=  SUCCESS COMPILE KERNEL =\033[0m"
    echo -e "$cyan===========================\033[0m"
else
echo -e "$red!ups...something wrong!?\033[0m"
fi

