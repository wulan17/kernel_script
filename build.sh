KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel3
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=X00PD_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
echo -e "\n(i) Cloning toolcahins if folder not exist..."
git clone https://github.com/raza231198/aarch64-linux-android-4.9

#Export needed values for the toolchain

export ARCH=arm64
export SUBARCH=arm64
export PATH=/usr/lib/ccache:$PATH
export KBUILD_BUILD_USER=Kherio
export KBUILD_BUILD_HOST=StormbrEakEr
export O=../out
export CROSS_COMPILE
export KERNEL_DIR=~/android/kernel
export OUT_DIR=~/out
export ZIPNAME=kernel-$(date -d "+1 hour" +%d.%m.%Y-%H:%M:%S).zip"

#Start the compilation

make O=../out X00PD_defconfig
make -j$(nproc --all) O=../out

#Create a flashable zip if the compilation succeded, abort if failed

if [ -f "${OUT_DIR}/arch/arm64/boot/Image.gz-dtb" ]; then
 echo -e "\033[1;32m Kernel compiled successfully! \033[0m"
 sleep 3s
 cd ${KERNEL_DIR}/anykernel
 rm *.zip > /dev/null 2>&1
 cp ${OUT_DIR}/arch/arm64/boot/Image.gz-dtb ${KERNEL_DIR}/anykernel
 zip -r9 "${ZIPNAME}" .
else
 echo -e "\033[1;31m Kernel compilation failed! \033[0m"
 exit 1
fi

