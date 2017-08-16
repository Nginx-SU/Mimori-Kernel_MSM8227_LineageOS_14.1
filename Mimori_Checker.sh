#!/bin/bash

#kernel directory for file location
zImage="TEMP/modules/zImage"

echo "Checking kernel..."
if [ -f "$zImage" ]
then
	echo "Kernel found."
	echo "Continue to build kernel"
	./Mimori_Builder.sh
	echo "Playing"
	message=${1:-"Aozora Jumping Heart"}
	notify-send -t 10000 -i TEMP/Additional/1.jpg "Aqours" "$message"
	paplay TEMP/Additional/1.flac
	cd /home/Hana/Mimori-Kernel
	make clean && make mrproper
	exit
else
	echo "Kernel not found."
	echo "Cancel kernel to build"
	echo "Playing"
	message=${1:-"Fuyu Ga Kureta Yokan"}
	notify-send -t 10000 -i TEMP/Additional/2.jpg "BiBi" "$message"
	paplay TEMP/Additional/2.flac
	echo "Cleaning up"
	cd /home/Hana/Mimori-Kernel
	make clean && make mrproper
	echo "Try to fix error"
	exit
fi
