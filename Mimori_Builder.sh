#!/bin/bash

cp TEMP/Pre-built_ZIP/Template/Mimori_Kernel.zip TEMP/Pre-built_ZIP/ZIP/Mimori_Kernel.zip
cd TEMP/Pre-built_ZIP/ZIP
unzip Mimori_Kernel.zip
cd /home/Hana/Mimori-Kernel
mv TEMP/modules/zImage TEMP/Pre-built_ZIP/ZIP/tmp/kernel/boot.img-zImage
mv TEMP/modules TEMP/Pre-built_ZIP/ZIP/tmp
cd TEMP/Pre-built_ZIP/ZIP
rm Mimori_Kernel.zip
zip -r Mimori_Kernel *
rm -rfv META-INF
rm -rfv system 
rm -rfv tmp
mv Mimori_Kernel.zip /home/Hana/Mimori-Kernel/TEMP/Pre-built_ZIP/Sign/Mimori_Kernel.zip
cd /home/Hana/Mimori-Kernel/TEMP/Pre-built_ZIP/Sign
java -jar signapk.jar signature-key.Nicklas@XDA.x509.pem signature-key.Nicklas@XDA.pk8 Mimori_Kernel.zip Mimori_Kernel-nicki-signed.zip
mv  Mimori_Kernel-nicki-signed.zip /home/Hana/Mimori-Kernel/Build/Mimori_Kernel-nicki-signed.zip
rm Mimori_Kernel.zip

echo "Mimori Kernel Completed to build"
echo "Thanks to XDA - Developers"
echo "プロジェクト　ラブライブ | Project MIMORI (2017)"
echo "あろがとう　ございます μ's !!!"
