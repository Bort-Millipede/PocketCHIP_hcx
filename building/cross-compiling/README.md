# Building hcxdumptool, hcxtools, and Wireless Driver (Cross-Compiling)

This describes how to build hcxdumptool, hcxtools, and the wireless driver (88XXau) for PocketCHIP using [cross-compilation](https://en.wikipedia.org/wiki/Cross_compiler) tools on an Ubuntu 14.04 virtual machine.

This method for building the required software is much faster than building the required software [directly on the PocketCHIP device itself](../native). However, setting up a cross-compilation environment can be a complicated undertaking that may not be suitable for less experienced users. Nonetheless, the author recommends this method for building the required software.

All cloned repositories and other files downloaded below will be saved to the `~/Downloads` directory.

## Requirements

This tutorial requires an Ubuntu 14.04 virtual machine. This can either be:
* The prebuilt `CHIP-SDK.ova` virtual machine available [HERE](https://archive.org/details/C.h.i.p.FlashCollection) (this is recommended by the author for simplicity's sake); OR
* A fresh Ubuntu 14.04 installation, after which [this setup script](https://raw.githubusercontent.com/techn0punk/CHIP-SDK/refs/heads/master/setup_ubuntu1404.sh) can be executed to install all the needed tools.

Initial setup of this virtual machine is not covered here. Only setup specifically required for building hcxdumptool, hcxtools, and the wireless driver is covered here.

## Installing Cross-Compilation Dependencies

Because the tools and driver will be build via cross-compilation, the required dependencies can only be installed manually. These will be installed from the *.deb files for the PocketCHIP to the `/usr/arm-linux-gnueabihf` directory on the Ubuntu 14.04 virtual machine.

Execute the following commands to download the files (replace `/path/to/` with path to the [deb_cross_urls.txt](deb_cross_urls.txt) file):

```bash
for u in `cat /path/to/deb_cross_urls.txt`; do wget -O `echo "$u" | rev | cut -d"/" -f 1 | rev` "$u"; done
```

&nbsp;  
Create the `deb_extract` directory and extract all downloaded *.deb files into this directory.

```bash
mkdir -p deb_extract
for f in `ls *.deb`; do dpkg-deb -R "$f" deb_extract; done
```

&nbsp;  
Relocate all library files to one directory, and recreate the `libz.so` file appropriately.

```bash
cd deb_extract/lib/arm-linux-gnueabihf/
mv * ../../usr/lib/arm-linux-gnueabihf/.
cd ../../usr/lib/arm-linux-gnueabihf/
rm libz.so
ln -s libz.so.1.2.8 libz.so
```

&nbsp;  
Install all extracted library files into the `/usr/arm-linux-gnueabihf/lib` directory.

```
sudo cp -r * /usr/arm-linux-gnueabihf/lib/.
```

&nbsp;  
Change to the directory containing the extracted header files and create necessary links for the `opensslconf.h` and `zconf.h` files.

```bash
cd ../../include
ln -s ../arm-linux-gnueabihf/openssl/opensslconf.h openssl/opensslconf.h
ln -s arm-linux-gnueabihf/zconf.h zconf.h
```

&nbsp;  
Install all extracted header files into the `/usr/arm-linux-gnueabihf/include` directory.

```bash
sudo cp -r * /usr/arm-linux-gnueabihf/include/.
```

&nbsp;  
All dependencies required for cross-compiling should now be installed.

## Building

### hcxdumptool 6.3.2

These instructions use [this commit](https://github.com/ZerBea/hcxdumptool/tree/24854050272c03d83e99ccd7d257f4d0db1bbf2b) from February 2024.

Clone the `hcxdumptool` repository and checkout the correct commit.

```bash
git clone https://github.com/ZerBea/hcxdumptool hcxdumptool-6.3.2-215-g2485405
cd hcxdumptool-6.3.2-215-g2485405
git checkout 24854050272c03d83e99ccd7d257f4d0db1bbf2b
```

&nbsp;  
Build hcxdumptool.

```bash
CC=arm-linux-gnueabihf-gcc make clean
CC=arm-linux-gnueabihf-gcc make
```

&nbsp;  
Create installation archive **hcxdumptool-6.3.2-215-g2485405.pocketchip.tar.gz** for installing onto the PocketCHIP device.

```bash
CC=arm-linux-gnueabihf-gcc make DESTDIR=`pwd` PREFIX=/usr/local install
cp usefulscripts/startnm usefulscripts/stopnm usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp man/* usr/local/share/man/man1/.
tar czf hcxdumptool-6.3.2-215-g2485405.pocketchip.tar.gz usr
```

### hcxdumptool 6.1.2

These instructions use [this commit](https://github.com/ZerBea/hcxdumptool/tree/e3df2d34689069522088331800a3c38b6b11ccd8) from September 2020.

Clone the `hcxdumptool` repository and checkout the correct commit.

```bash
git clone https://github.com/ZerBea/hcxdumptool hcxdumptool-6.1.2-8-ge3df2d3
cd hcxdumptool-6.1.2-8-ge3df2d3
git checkout e3df2d34689069522088331800a3c38b6b11ccd8
```

&nbsp;  
Build hcxdumptool.

```bash
CC=arm-linux-gnueabihf-gcc make clean
CC=arm-linux-gnueabihf-gcc make
```

&nbsp;  
Create installation archive **hcxdumptool-6.1.2-8-ge3df2d3.pocketchip.tar.gz** for installing onto the PocketCHIP device.

```bash
CC=arm-linux-gnueabihf-gcc make DESTDIR=`pwd` install
cp usefulscripts/killmonnb usefulscripts/makemonnb usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxdumptool-6.1.2-8-ge3df2d3.pocketchip.tar.gz usr
```

### hcxtools 6.1.3

These instructions use [this commit](https://github.com/ZerBea/hcxtools/tree/f6695efe646cff4a8c434af9ad01059c2fb5e515) from November 2020.

Clone the `hcxtools` repository and checkout the correct commit.

```bash
git clone https://github.com/ZerBea/hcxtools hcxtools-6.1.3-53-gf6695ef
cd hcxtools-6.1.3-53-gf6695ef
git checkout f6695efe646cff4a8c434af9ad01059c2fb5e515
```

&nbsp;  
Build hcxtools.

```bash
CC=arm-linux-gnueabihf-gcc make clean
CC=arm-linux-gnueabihf-gcc make
```

&nbsp;  
Create installation archive **hcxtools-6.1.3-53-gf6695ef.pocketchip.tar.gz** for installing onto the PocketCHIP device.

```bash
CC=arm-linux-gnueabihf-gcc make DESTDIR=`pwd` install
cp usefulscripts/hcxgrep.py usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxtools-6.1.3-53-gf6695ef.pocketchip.tar.gz usr
```

### hcxtools 5.3.0

These instructions use [this commit](https://github.com/ZerBea/hcxtools/tree/52d984890f3df31ecb4333681fb2512318ada6f9) from December 2019.

Clone the `hcxtools` repository and checkout the correct commit.

```bash
git clone https://github.com/ZerBea/hcxtools hcxtools-5.3.0
cd hcxtools-5.3.0
git checkout 52d984890f3df31ecb4333681fb2512318ada6f9
```

&nbsp;  
Build hcxtools.

```bash
CC=arm-linux-gnueabihf-gcc make clean
CC=arm-linux-gnueabihf-gcc make
```

&nbsp;  
Create installation archive **hcxtools-5.3.0.pocketchip.tar.gz** for installing onto the PocketCHIP device.

```bash
CC=arm-linux-gnueabihf-gcc make DESTDIR=`pwd` install
cp usefulscripts/hcxgrep.py usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxtools-5.3.0.pocketchip.tar.gz usr
```

### Wireless Driver (rtl8812au v5.6.4.2_35491.20191025)

These instructions use [this commit](https://github.com/aircrack-ng/rtl8812au/tree/e7e83f2593c9e67e3ee50d032f1ad39fe47ea81d) from April 2021. The driver is compiled against the Linux kernel source, and therefore the Linux kernel source for 4.4.13-ntc-mlc (the kernel version in use on Linux on the PocketCHIP device) is also required (found [HERE](https://github.com/joelguittet/chip-linux/tree/debian/4.4.13-ntc-mlc)).

Lastly, the Linux kernel config file is required. This can be found on the PocketCHIP device at `/boot/config-4.4.13-ntc-mlc`.

Obtain the Linux kernel source. Clone the `debian/4.4.13-ntc-mlc` branch of the `chip-linux` repository.

```bash
git clone -b debian/4.4.13-ntc-mlc https://github.com/joelguittet/chip-linux.git chip-linux_4.4.13-ntc-mlc
cd chip-linux_4.4.13-ntc-mlc
```

&nbsp;  
Clear out all previous kernel builds and configurations, copy the Linux kernel config file to the directory (replace `/path/to/` with path to the kernel config file), and update the Kernel version specified in the Makefile to `4.4.13-ntc-mlc`.

```bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= mrproper
cp /path/to/config-4.4.13-ntc-mlc .config
sed -i.bak 's/^EXTRAVERSION =[\s]\{0,\}$/EXTRAVERSION = -ntc-mlc/g' Makefile
```

&nbsp;  
Perform preliminary setup of the kernel source directory. If prompted by `make oldconfig` command to make choices, pressing `ENTER` will choose the default choice.  
To immediately exit out of `make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= menuconfig` command, press: `ESC ESC`

```bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= oldconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= menuconfig
```

&nbsp;  
Prepare the kernel source and modules for building.

```bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= prepare
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOCALVERSION= modules_prepare
```

&nbsp;  
Save the location of the kernel source directory to an environment variable, then leave the kernel source directory.
```bash
KSRC=`pwd`
cd ..
```

&nbsp;  
Obtain the wireless driver source. Clone the `rtl8812au` repository and checkout the correct commit.

```bash
git clone https://github.com/aircrack-ng/rtl8812au rtl8812au-v5.6.4.2_35491.20191025
cd rtl8812au-v5.6.4.2_35491.20191025
git checkout e7e83f2593c9e67e3ee50d032f1ad39fe47ea81d
```

&nbsp;  
Update the `Makefile` to configure the driver for a 32-bit ARM processor.

```bash
sed -i.bak 's/EXTRA_CFLAGS += -Wimplicit-fallthrough=0/#EXTRA_CFLAGS += -Wimplicit-fallthrough=0/g' Makefile
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
```

&nbsp;  
Build the driver. The compiled kernel module will be the `88XXau.ko` file.

```bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j2 KVER=4.4.13-ntc-mlc KSRC=$KSRC
```

&nbsp;  
Confirm that the kernel module was compiled for the correct kernel version. The output of the following command should be `vermagic: 4.4.13-ntc-mlc SMP mod_unload ARMv7 p2v8`

```bash
modinfo ./88XXau.ko | grep vermagic
```

&nbsp;  
Compress the kernel module for installing onto the PocketCHIP device later.

```bash
gzip -c 88XXau.ko > 88XXau_v5.6.4.2_35491.20191025_4.4.13-ntc-mlc.pocketchip.gz
```

## [Installation on PocketCHIP](https://github.com/Bort-Millipede/PocketCHIP_hcx#Installation)

Outlined in main README under **Installation**.

