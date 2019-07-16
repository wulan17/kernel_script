# Main Environment
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel3
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs
CONFIG=X00PD_defconfig
CORES=$(grep -c ^processor /proc/cpuinfo)
THREAD="-j$CORES"
CROSS_COMPILE+="ccache "
CROSS_COMPILE+="$PWD/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

# Modules environtment
OUTDIR="$PWD/out/"
SRCDIR="$PWD/"
MODULEDIR="$PWD/AnyKernel3/modules/system/lib/modules/"
PRIMA="$PWD/AnyKernel3/modules/vendor/lib/modules/wlan.ko"
PRONTO="$PWD/AnyKernel3/modules/vendor/lib/modules/pronto/pronto_wlan.ko"
STRIP="$PWD/aarch64-linux-android-4.9/bin/$(echo "$(find "$PWD/aarch64-linux-android-4.9/bin" -type f -name "aarch64-*-gcc")" | awk -F '/' '{print $NF}' |\
			sed -e 's/gcc/strip/')"



		echo -e "\n(i) Cloning toolcahins if folder not exist..."
		git clone https://github.com/raza231198/aarch64-linux-android-4.9

                echo -e "\n(i) Cloning AnyKernel3 if folder not exist..."
		git clone -b X00PD-zenui https://github.com/raza231198/AnyKernel3

		echo -e "\n(i) Strip and move modules to AnyKernel3..."

		# thanks to @adekmaulana

		cd $ZIP_DIR
		make clean &>/dev/null
		cd ..

		for MOD in $(find "${OUTDIR}" -name '*.ko') ; do
			"${STRIP}" --strip-unneeded --strip-debug "${MOD}" &> /dev/null
			"${SRCDIR}"/scripts/sign-file sha512 \
					"${OUTDIR}/signing_key.priv" \
					"${OUTDIR}/signing_key.x509" \
					"${MOD}"
			find "${OUTDIR}" -name '*.ko' -exec cp {} "${MODULEDIR}" \;
			case ${MOD} in
				*/wlan.ko)
					cp -ar "${MOD}" "${PRIMA}"
					cp -ar "${MOD}" "${PRONTO}"
			esac
		done
		echo -e "\n(i) Done moving modules"

		rm $PWD/AnyKernel3/modules/system/lib/modules/wlan.ko
		cd $ZIP_DIR
		cp $KERN_IMG $ZIP_DIR/zImage
		make normal
