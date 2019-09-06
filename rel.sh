#!/bin/bash
$HOME/build_kernel/telegram -M "Build completed successfully in $((BUILD_DIFF / 60)) minute(s) and $((BUILD_DIFF % 60)) seconds
Download : ["$zip_name".zip](buttonurl://https://github.com/wulan17/kernel_script/releases/download/"$TRAVIS_TAG"/"$zip_name".zip)""