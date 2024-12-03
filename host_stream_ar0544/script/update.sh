cd /mnt/flash/vienna/drivers
tftp -gr IMX662.ko 192.168.1.9
tftp -gr IMX335.ko 192.168.1.9
chmod +x *.ko
