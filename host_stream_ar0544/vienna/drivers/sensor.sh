#!/bin/sh
insmod vpl_vic.ko gdwSignalWaitTime=4000 > /dev/null 2>&1;
insmod AR0544.ko
