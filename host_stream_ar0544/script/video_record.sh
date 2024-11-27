#!/bin/sh

count=`ps -ef |grep vrec |grep -v "grep" |wc -l`
   #echo $count
    if [ 0 != $count ];then
        exit 0
    fi

mkdir -p /tmp/vrecord/videoclips/
mount /dev/mmcblk0 /tmp/vrecord/videoclips/

cd ../plus/kp_firmware/kp_firmware_0/kp_firmware/bin/;
export LD_LIBRARY_PATH=$(pwd)/../lib;
./vrec -s 30 -c vrec_conf.ini

exit 0

#cd /mnt/flash/vienna/;
#sh ./start.sh;

# "PLUS FW PART"
# enable auto reboot when kernel panic
#echo 3 > /proc/sys/kernel/panic
#/sbin/watchdog -T 3 -t 2 /dev/watchdog

#echo "plus_init"
#sh /mnt/flash/etc/plus_usb_companion_init.sh
