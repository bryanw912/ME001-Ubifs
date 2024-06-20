#!/bin/bash
#How to execute:
#cd to current path
#. ./init_usb_device_kl630.sh

#Please make sure the usb gadget related lib already put to vienna\lib.
#usb gadget related lib
#libconfig.so.9.2.0, libconfig.so.9
#libusbgx.so.1, libusbgx.so, libusbgx.so.2, libusbgx.so.2.0.0


export PATH=$(pwd):$PATH
export LD_LIBRARY_PATH=$(pwd)/lib:$LD_LIBRARY_PATH
echo "[init_usb_device_kl630.sh] show current env path we need"
env|grep PATH
echo "[init_usb_device_kl630.sh] insert usb gadget related drivers"
mount -t debugfs none /sys/kernel/debug
insmod driver/libcomposite.ko
insmod driver/usb_f_fs.ko
mount none /sys/kernel/config/ -t configfs


usb_fd=/dev/ffs_plus

#cd build/kdp2_plus/bin
echo "[init_usb_device_kl630.sh] gt load g1"
gt load g1 --file=./kl630.gs -o

echo "[init_usb_device_kl630.sh] re-create usb_fd"
if [ ! -e $usb_fd ];then
    mkdir $usb_fd
fi

echo "[init_usb_device_kl630.sh] mount usb fd"
mount plus $usb_fd -t functionfs

