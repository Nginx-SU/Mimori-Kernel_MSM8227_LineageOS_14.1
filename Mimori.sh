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
###Running GCC Toolchains 4.9 (Hyper Toolchains)"
export ARCH=arm
export CROSS_COMPILE=/home/Hana/Hyper-Toolchains/bin/arm-linux-androideabi-

echo "
###Building Mimori Kernel"
make ARCH=arm mimori_nicki_defconfig
make ARCH=arm CROSS_COMPILE=/home/Hana/Hyper-Toolchains/bin/arm-linux-androideabi- > mimori.log

echo "
##Creating Temporary Modules kernel"
mkdir modules
cp arch/arm/boot/zImage modules
find . -name "*.ko" -exec cp {} modules \;
cd modules
/home/Hana/Hyper-Toolchains/bin/arm-linux-androideabi-strip --strip-unneeded *.ko
cd /home/Hana/Mimori-Kernel
mv modules TEMP

echo "
##Checking Kernel Process"
./Mimori_Checker.sh
