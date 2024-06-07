#!/bin/sh
insmod vpl_vic.ko gdwSignalWaitTime=4000 > /dev/null 2>&1;
insmod IMX662.ko
