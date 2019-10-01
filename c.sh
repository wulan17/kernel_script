#$HOME/build_kernel/telegram -M "Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
#Download : ["$zip_name".zip](https://github.com/wulan17/kernel_script2/releases/download/"$TRAVIS_TAG"/"$zip_name".zip)"

curl -v -F "chat_id=$TELEGRAM_CHAT" -F document=@$HOME/build_kernel/AnyKernel/$zip_name.zip -F "parse_mode=html" -F caption="Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
Dev : wulan17

Product : Kernel

Device : #cactus

Branch : Pie

Compiler : ""$(gcc --version)""

Compiler : ""$(${CROSS_COMPILE}gcc --version | head -n 1)""

Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument