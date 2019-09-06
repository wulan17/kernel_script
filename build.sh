# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm/boot/zImage-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel3
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
CONFIG=cactus_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"

echo -e "\n(i) Cloning toolcahins if folder not exist..."
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git arm-linux-androideabi-4.9

# Export
export ARCH=arm
export SUBARCH=arm
export PATH=/usr/lib/ccache:$PATH
export CROSS_COMPILE
export KBUILD_BUILD_USER=wulan17
export KBUILD_BUILD_HOST=Travis-CI
make  O=out $CONFIG $THREAD
