#! /bin/bash

if [[ $EUID -ne 0 ]]
then
	echo -e "Error: This script must be executed as root! exiting..." 
	exit 1
fi

lsmod | grep 88XXau >/dev/null
if [  $? -ne 0 ]
then
	modprobe 88XXau 2>/dev/null
	if [  $? -ne 0 ]
	then
		echo "Wireless driver kernel module could not be loaded! Ensure correct driver is installed, then re-execute this helper script."
		echo -e "Alternatively, try manually loading the kernel module:\n\t/sbin/insmod /path/to/88XXau.ko"
		echo "and inspect any immediate output and output printed to the 'dmesg' command"
		exit 1
	fi
fi

airmon-ng | grep rtl88XXau >/dev/null
if [ $? -ne 0 ]
then
	echo "USB Wireless adapter not detected! Ensure it is plugged into the PocketCHIP, then re-execute this helper script."
	exit 2
fi

IFACE=`airmon-ng | grep rtl88XXau | tr "\t" " " | tr -s " " | cut -d" " -f 1`
iwconfig "$IFACE" >/dev/null
if [ $? -ne 0 ]
then
	echo "USB Wireless adapter detected as $IFACE device, but error occurred retrieving device information! Device may not operate correctly!"
	exit 3
else
	echo "USB Wireless adapter successfully detected as $IFACE device!"
	exit 0
fi
