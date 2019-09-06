#!/bin/bash
$HOME/build_kernel/telegram -M "Build Start
Dev : wulan17
Product : Kernel
Device : #cactus
Branch : Oreo
Compiler : ""$(gcc --version)""
Compiler : ""$($HOME/kernel/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-gcc --version | head -n 1)""
Date : ""$(env TZ=Asia/Jakarta date)"""
