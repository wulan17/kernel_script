# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm/boot/zImage-dtb
ZIP_DIR=$HOME/build_kernel/AnyKernel
CONFIG_DIR=$KERNEL_DIR/arch/arm/configs
CONFIG=cactus_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"
export zip_name="kernel-cactus-"$(env TZ='Asia/Jakarta' date +%Y%m%d)""
cp $KERN_IMG $ZIP_DIR
cd $ZIP_DIR
mv zImage-dtb zImage
BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))
export tag=$(date +'%Y%m%d%H%M%S')
zip -r $zip_name.zip ./*
$HOME/build_kernel/github-release "$release_repo" "$tag" "oreo" "Kernel for cactus
Date: $(env TZ="$timezone" date)" "$zip_name.zip"
$HOME/build_kernel/telegram -M "Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
Download : ["$zip_name".zip](https://github.com/wulan17/kernel_script/releases/download/"$tag"/"$zip_name".zip)"
