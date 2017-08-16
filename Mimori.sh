#!/bin/bash

echo "
######################################################
#                                                    #
#                    Mimori Kernel                   #
#                                                    #
#                Nicklas Van Dam @XDA                #
#                                                    #
#	   PRIVATE DEVELOPMENT OF Hana Kernel	     #
#						     #
######################################################"

echo "
###Running GCC Toolchains 4.9 (Google GCC)"
export ARCH=arm
export CROSS_COMPILE=/home/Hana/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-

echo "
###Building Hana Kernel"
make ARCH=arm mimori_kernel_nicki_defconfig
make ARCH=arm CROSS_COMPILE=/home/Hana/arm-linux-androideabi-4.9/bin/arm-linux-androideabi- > mimori.log

echo "
##Creating Temporary Modules kernel"
mkdir modules
cp arch/arm/boot/zImage modules
find . -name "*.ko" -exec cp {} modules \;
cd modules
/home/Hana/mimori/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-strip --strip-unneeded *.ko
cd /home/Hana/android_kernel_sony_msm8x27-cm-14.1
mv modules TEMP

echo "
##Checking Kernel Process"
./Mimori_Checker.sh
