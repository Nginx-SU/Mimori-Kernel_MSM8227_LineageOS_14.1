#!/bin/bash
#
# Copyright 2017, Dicky Herlambang "Nicklas373" <herlambangdicky5@gmail.com>
#
# Mimori Kernel Builder Script
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

#Logic Memory
CROSS_COMPILE_4="/home/mimori/Hyper-Toolchains/bin"
CROSS_COMPILE_5="/media/mimori/50644BA7644B8EA2/GCC/arm-linux-androideabi-5.x/bin"
kernel_temp_modules="/home/mimori/Mimori-Kernel/arch/arm/boot/zImage"
kernel_source="/home/mimori/Mimori-Kernel"
kernel_zip="/home/mimori/Mimori-Kernel/TEMP/Pre-built_ZIP/ZIP"
zImage="/home/mimori/Mimori-Kernel/TEMP/modules/zImage"
temp="/home/mimori/Mimori-Kernel/TEMP"
modules="/home/mimori/Mimori-Kernel/modules"

#Logic Answer Memory
answer(){
A="1"
B="2"
C="Yes"
D="No"
}

#Kernel Builder
build(){
cp TEMP/Pre-built_ZIP/Template/Mimori_Kernel.zip TEMP/Pre-built_ZIP/ZIP/Mimori_Kernel.zip
cd $kernel_zip
unzip Mimori_Kernel.zip
cd /home/mimori/Mimori-Kernel
mv TEMP/modules/zImage TEMP/Pre-built_ZIP/ZIP/tmp/kernel/boot.img-zImage
mv TEMP/modules TEMP/Pre-built_ZIP/ZIP/tmp
cd TEMP/Pre-built_ZIP/ZIP
rm Mimori_Kernel.zip
zip -r Mimori_Kernel *
rm -rfv META-INF
rm -rfv system 
rm -rfv tmp
mv Mimori_Kernel.zip /home/mimori/Mimori-Kernel/TEMP/Pre-built_ZIP/Sign/Mimori_Kernel.zip
cd /home/mimori/Mimori-Kernel/TEMP/Pre-built_ZIP/Sign
java -jar signapk.jar signature-key.Nicklas@XDA.x509.pem signature-key.Nicklas@XDA.pk8 Mimori_Kernel.zip Mimori_Kernel-nicki-signed.zip
mv  Mimori_Kernel-nicki-signed.zip /home/mimori/Mimori-Kernel/Build/Mimori_Kernel-nicki-signed.zip
rm Mimori_Kernel.zip
echo "Mimori Kernel Completed to build"
echo "Thanks to XDA - Developers"
echo "プロジェクト　ラブライブ | Project MIMORI (2017)"
echo "あろがとう　ございます μ's !!!"
}

#Kernel Checking
checking(){
echo "Checking kernel..."
if [ -f "$zImage" ]
then
	echo "Kernel found"
	echo "Continue to build kernel"
	build
	message=${1:-"Aozora Jumping Heart"}
	notify-send -t 10000 -i TEMP/Additional/1.jpg "Aqours" "$message"
	paplay TEMP/Additional/1.flac
	echo "Cleaning up"
	cd $kernel_source
	make clean && make mrproper
	exit
else
	echo "Kernel not found"
	echo "Cancel kernel to build"
	gedit mimori.log
	message=${1:-"Fuyu Ga Kureta Yokan"}
	notify-send -t 10000 -i TEMP/Additional/2.jpg "BiBi" "$message"
	paplay TEMP/Additional/2.flac
	echo "Cleaning up"
	cd $kernel_source
	make clean && make mrproper
	echo "Try to fix error"
	exit
fi
}

#Kernel Modules GCC4
modules_gcc_4(){
echo "##Creating Temporary Modules kernel"
mkdir modules
cp $kernel_temp_modules $modules
find . -name "*.ko" -exec cp {} $modules \;
cd modules
$CROSS_COMPILE/arm-linux-androideabi-strip --strip-unneeded *.ko
cd $kernel_source
mv $modules $temp
}

#Kernel Modules GCC5
modules_gcc_5(){
echo "##Creating Temporary Modules kernel"
mkdir modules
cp $kernel_temp_modules $modules
find . -name "*.ko" -exec cp {} $modules \;
cd modules
$CROSS_COMPILE_5/arm-linux-androideabi-strip --strip-unneeded *.ko
cd $kernel_source
mv $modules $temp
}

#Invalid Option
invalid(){
echo "Your Option Is Invalid"
echo "Return to main menu ?"
echo "1. Yes"
echo "2. No"
echo "(Yes / No)"
read option
answer
if [ "$option" == "$C" ];
	then
		menu_compile
fi
if [ "$option" == "$D" ];
	then
		echo "See You Later"
		exit
fi
}

#Main Program
menu_compile(){
echo "
######################################################
#                                                    #
#                    Mimori Kernel                   #
#                                                    #
#                Nicklas Van Dam @XDA                #
#                                                    #
#	   PRIVATE DEVELOPMENT OF mimori Kernel	     #
#						     #
######################################################"
echo "Welcome To Mimori Kernel Builder"
echo "Select Which GCC To Use ?"
echo "1. GCC 4.9.X"
echo "2. GCC 5.4.X"
echo "( 1 / 2)"
read choice
answer
if [ "$choice" == "$A" ];
	then
		echo "##Running GCC Toolchains 4.9 (Hyper Toolchains)"
		export ARCH=arm 
		export CROSS_COMPILE=$CROSS_COMPILE_4/arm-linux-androideabi-
		echo "##Building Mimori Kernel"
		make ARCH=arm mimori_nicki_defconfig
		make ARCH=arm CROSS_COMPILE=$CROSS_COMPILE_4/arm-linux-androideabi- -> mimori.log
		modules_gcc_4
		checking
fi
if [ "$choice" == "$B" ];
	then
		echo "##Running GCC Toolchains 5.4 (Hyper Toolchains)"
		export ARCH=arm 
		export CROSS_COMPILE=$CROSS_COMPILE_5/arm-linux-androideabi-
		echo "##Building Mimori Kernel"
		make ARCH=arm mimori_nicki_defconfig
		make ARCH=arm CROSS_COMPILE=$CROSS_COMPILE_5/arm-linux-androideabi- -> mimori.log
		modules_gcc_5
		checking
	else
		invalid
fi
}

#Execute Program
menu_compile
