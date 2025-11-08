# Building hcxdumptool, hcxtools, and Wireless Driver (on PocketCHIP)

This describes how to build hcxdumptool, hcxtools, and the wireless driver ([RTL8812AU](https://github.com/aircrack-ng/rtl8812au)) for PocketCHIP directly on the device.

This method for building the required software is much simpler than building the software [via cross-compilation](../cross-compiling). However, due to the limited processing power of the PocketCHIP device, this method may take an extended period of time to complete. For this reason and others, the author does NOT recommend this method for building the required software.

All cloned repositories and other files downloaded below will be saved to the `~/Downloads` directory.

## Install Dependencies

The following command will install the required dependencies via APT (Recommend using the CHIP mirror described [HERE](http://chip.jfpossibilities.com/chip/debian/)).

```bash
sudo apt install aircrack-ng libcurl4-openssl-dev libssl-dev zlib1g-dev libc6 libc6-dev linux-libc-dev make gcc build-essential git
```

Alternatively, some (but not all) of the dependencies can be installed by downloading the *.deb files themselves and installing thing. Execute the following commands to download and install the files (replace `/path/to/` with path to the [deb_urls.txt](../../deb_urls.txt) file).

```bash
cd ~/Downloads
for u in `cat /path/to/deb_urls.txt`; do wget -O `echo "$u" | rev | cut -d"/" -f 1 | rev` "$u"; done
sudo dpkg -i -E *.deb
```

**NOTE:** Some of these packages are likely already installed on Linux on PocketCHIP by default, so the above command will only install packages that are not already installed.

## Building and Installing

### hcxdumptool 6.3.2

These instructions use [this commit](https://github.com/ZerBea/hcxdumptool/tree/24854050272c03d83e99ccd7d257f4d0db1bbf2b) from February 2024.

Clone the `hcxdumptool` repository and checkout the correct commit.

```bash
cd ~/Downloads
git clone https://github.com/ZerBea/hcxdumptool hcxdumptool-6.3.2-215-g2485405
cd hcxdumptool-6.3.2-215-g2485405
git checkout 24854050272c03d83e99ccd7d257f4d0db1bbf2b
```

&nbsp;  
Build hcxdumptool.

```bash
make clean
make
```

&nbsp;  
Install hcxdumptool 6.3.2 to the system (under `/usr/local`).

```bash
sudo make PREFIX=/usr/local install
sudo cp usefulscripts/startnm usefulscripts/stopnm /usr/local/bin/.
sudo mkdir -p /usr/local/share/man/man1
sudo cp man/* /usr/local/share/man/man1/.
```

&nbsp;  
**OPTIONAL:** Create installation archive **hcxdumptool-6.3.2-215-g2485405.pocketchip.tar.gz** for installing onto the PocketCHIP device again later (ex. after a device re-flash).

```bash
make DESTDIR=`pwd` PREFIX=/usr/local install
cp usefulscripts/startnm usefulscripts/stopnm usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp man/* usr/local/share/man/man1/.
tar czf hcxdumptool-6.3.2-215-g2485405.pocketchip.tar.gz usr
```

### hcxdumptool 6.1.2

These instructions use [this commit](https://github.com/ZerBea/hcxdumptool/tree/e3df2d34689069522088331800a3c38b6b11ccd8) from September 2020.

Clone the `hcxdumptool` repository and checkout the correct commit.

```bash
cd ~/Downloads
git clone https://github.com/ZerBea/hcxdumptool hcxdumptool-6.1.2-8-ge3df2d3
cd hcxdumptool-6.1.2-8-ge3df2d3
git checkout e3df2d34689069522088331800a3c38b6b11ccd8
```

&nbsp;  
Build hcxdumptool.

```bash
make clean
make
```

&nbsp;  
Install hcxdumptool 6.1.2 to the system (under `/usr/local`).

```bash
sudo make install
sudo cp usefulscripts/killmonnb usefulscripts/makemonnb /usr/local/bin/.
sudo mkdir -p /usr/local/share/man/man1
sudo cp manpages/* /usr/local/share/man/man1/.
```

&nbsp;  
**OPTIONAL:** Create installation archive **hcxdumptool-6.1.2-8-ge3df2d3.pocketchip.tar.gz** for installing onto the PocketCHIP device again later (ex. after a device re-flash).

```bash
make DESTDIR=`pwd` install
cp usefulscripts/killmonnb usefulscripts/makemonnb usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxdumptool-6.1.2-8-ge3df2d3.pocketchip.tar.gz usr
```

### hcxtools 6.1.3

These instructions use [this commit](https://github.com/ZerBea/hcxtools/tree/f6695efe646cff4a8c434af9ad01059c2fb5e515) from November 2020.

Clone the `hcxtools` repository and checkout the correct commit.

```bash
cd ~/Downloads
git clone https://github.com/ZerBea/hcxtools hcxtools-6.1.3-53-gf6695ef
cd hcxtools-6.1.3-53-gf6695ef
git checkout f6695efe646cff4a8c434af9ad01059c2fb5e515
```

&nbsp;  
Build hcxtools.  
**Note:** this may take a while to complete.

```bash
make clean
make
```

&nbsp;  
Install hcxtools 6.1.3 to the system (under `/usr/local`).

```bash
sudo make install
sudo cp usefulscripts/hcxgrep.py /usr/local/bin/.
sudo mkdir -p /usr/local/share/man/man1
sudo cp manpages/* /usr/local/share/man/man1/.
```

&nbsp;  
**OPTIONAL:** Create installation archive **hcxtools-6.1.3-53-gf6695ef.pocketchip.tar.gz** for installing onto the PocketCHIP device again later (ex. after a device re-flash).

```bash
make DESTDIR=`pwd` install
cp usefulscripts/hcxgrep.py usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxtools-6.1.3-53-gf6695ef.pocketchip.tar.gz usr
```

### hcxtools 5.3.0

These instructions use [this commit](https://github.com/ZerBea/hcxtools/tree/52d984890f3df31ecb4333681fb2512318ada6f9) from December 2019.

Clone the `hcxtools` repository and checkout the correct commit.

```bash
cd ~/Downloads
git clone https://github.com/ZerBea/hcxtools hcxtools-5.3.0
cd hcxtools-5.3.0
git checkout 52d984890f3df31ecb4333681fb2512318ada6f9
```

&nbsp;  
Build hcxtools.  
**Note:** this may take a while to complete.

```bash
make clean
make
```

&nbsp;  
Install hcxtools 5.3.0 to the system (under `/usr/local`).

```bash
sudo make install
sudo cp usefulscripts/hcxgrep.py /usr/local/bin/.
sudo mkdir -p /usr/local/share/man/man1
sudo cp manpages/* /usr/local/share/man/man1/.
```

&nbsp;  
**OPTIONAL:** Create installation archive **hcxtools-5.3.0.pocketchip.tar.gz** for installing onto the PocketCHIP device again later (ex. after a device re-flash).

```bash
make DESTDIR=`pwd` install
cp usefulscripts/hcxgrep.py usr/local/bin/.
mkdir -p usr/local/share/man/man1
cp manpages/* usr/local/share/man/man1/.
tar czf hcxtools-5.3.0.pocketchip.tar.gz usr
```

### Wireless Driver (rtl8812au v5.6.4.2_35491.20191025)

These instructions use [this commit](https://github.com/aircrack-ng/rtl8812au/tree/e7e83f2593c9e67e3ee50d032f1ad39fe47ea81d) from April 2021. The driver is compiled against the Linux kernel source, and therefore the Linux kernel source for `4.4.13-ntc-mlc` (the kernel version in use on Linux on the PocketCHIP device) is also required (found [HERE](https://github.com/joelguittet/chip-linux/tree/debian/4.4.13-ntc-mlc)).

Obtain the Linux kernel source. Clone the `debian/4.4.13-ntc-mlc` branch of the `chip-linux` repository.  
**Note:** This will likely take a VERY long time to complete.

```bash
sudo mkdir -p /usr/src
cd /usr/src
sudo git clone -b debian/4.4.13-ntc-mlc https://github.com/joelguittet/chip-linux.git linux-source-4.4.13-ntc-mlc
cd linux-source-4.4.13-ntc-mlc
```

&nbsp;  
Clear out all previous kernel builds and configurations, copy the Linux kernel config file to the directory, and update the Kernel version specified in the Makefile to `4.4.13-ntc-mlc`.

```bash
sudo make LOCALVERSION= mrproper
sudo cp /boot/config-4.4.13-ntc-mlc .config
sudo sed -i.bak 's/^EXTRAVERSION =[\s]\{0,\}$/EXTRAVERSION = -ntc-mlc/g' Makefile
```

&nbsp;  
Perform preliminary setup of the kernel source directory. If prompted by `make oldconfig` command to make choices, pressing `ENTER` will choose the default choice.  
To immediately exit out of the `make menuconfig` command, press: `ESC ESC`  
**Note:** These commands may take a while to complete.

```bash
sudo make LOCALVERSION= oldconfig
sudo make LOCALVERSION= menuconfig
```

&nbsp;  
Prepare the kernel source and modules for building.  
**Note:** These will like take a VERY long time to complete.

```bash
sudo make LOCALVERSION= prepare
sudo make LOCALVERSION= modules_prepare
```

&nbsp;  
Obtain the wireless driver source. Clone the `rtl8812au` repository and checkout the correct commit.  
**Note:** These will likely take a long time to complete.

```bash
cd ~/Downloads
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
Build the driver. The compiled kernel module will be the outputted `88XXau.ko` file.  
**Note:** This will likely take a long time to complete.

```bash
make -j2 KVER=4.4.13-ntc-mlc KSRC=/usr/src/linux-source-4.4.13-ntc-mlc
```

&nbsp;  
Confirm that the kernel module was compiled for the correct kernel version. The output of the following command should be `vermagic: 4.4.13-ntc-mlc SMP mod_unload ARMv7 p2v8`

```bash
modinfo ./88XXau.ko | grep vermagic
```

&nbsp;  
Install the wireless driver (loadable kernel module) to the correct directory and regenerate the system's list of kernel module dependencies.

```bash
sudo make -j2 KVER=4.4.13-ntc-mlc KSRC=/usr/src/linux-source-4.4.13-ntc-mlc install
```

&nbsp;  
**OPTIONAL:** Compress the kernel module for installing onto the PocketCHIP device again later (ex. after a device re-flash).

```bash
gzip -c 88XXau.ko > 88XXau_v5.6.4.2_35491.20191025_4.4.13-ntc-mlc.pocketchip.gz
```

