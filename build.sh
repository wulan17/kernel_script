# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm/boot/zImage-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
CONFIG=cactus_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"

echo -e "\n(i) Cloning toolcahins if folder not exist..."
git clone https://github.com/wulan17/prebuilts_gcc_linux-x86_arm-linux-androideabi-4.9.git arm-linux-androideabi-4.9
chmod a+x /home/travis/kernel/arm-linux-androideabi-4.9/bin/*
chmod a+x /home/travis/kernel/arm-linux-androideabi-4.9/libexec/gcc/arm-linux-androideabi/4.9.x/*
chmod a+x /home/travis/kernel/arm-linux-androideabi-4.9/libexec/gcc/arm-linux-androideabi/4.9.x/plugin/*

cd $HOME/kernel && wget https://github.com/wulan17/android_kernel_xiaomi_cactus/commit/63623ef9ea9260810d10c2422d4548470a29f304.patch
cd $HOME/kernel && git am < 63623ef9ea9260810d10c2422d4548470a29f304.patch

$HOME/build_kernel/telegram -M "Build Start
Dev : wulan17

Product : Kernel

Device : #cactus

Branch : Pie

Compiler : ""$(gcc --version)""

Compiler : ""$(${CROSS_COMPILE}gcc --version | head -n 1)""

Date : ""$(env TZ=Asia/Jakarta date)"""

# Export
export ARCH=arm
export SUBARCH=arm
export PATH=/usr/lib/ccache:$PATH
export CROSS_COMPILE
export KBUILD_BUILD_USER=wulan17
export KBUILD_BUILD_HOST=Travis-CI
make  O=out $CONFIG $THREAD
