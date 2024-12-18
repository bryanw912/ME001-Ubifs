#!/bin/sh
cd vienna/drivers/;
sh driver.sh;

mkdir -p /tmp/venc/c0/;
mkdir -p /tmp/aenc/c0/;
mkdir -p /tmp/playback/c0/;
mkdir -p /tmp/twoway/c0/;
mkdir -p /tmp/sr/c0/;

cd ../../plus/kp_firmware/kp_firmware_0/kp_firmware/bin/;
export LD_LIBRARY_PATH=$(pwd)/../lib;
./rtsps -c stream_server_config.ini &
./kp_firmware_host_stream

#cd /mnt/flash/vienna/;
#sh ./start.sh;

# "PLUS FW PART"
# enable auto reboot when kernel panic
#echo 3 > /proc/sys/kernel/panic
#/sbin/watchdog -T 3 -t 2 /dev/watchdog

#echo "plus_init"
#sh /mnt/flash/etc/plus_usb_companion_init.sh
     