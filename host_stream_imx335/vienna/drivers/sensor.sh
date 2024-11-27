#!/bin/sh
insmod vpl_vic.ko gdwSignalWaitTime=4000 > /dev/null 2>&1;
insmod IMX335.ko
#insmod IMX662_v1.0.0.1.ko
