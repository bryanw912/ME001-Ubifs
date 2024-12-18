#!/bin/sh
while :
do
scale=`cat /sys/bus/iio/devices/iio\:device1/in_accel_scale`
x=`cat /sys/bus/iio/devices/iio\:device1/in_accel_x_raw`
y=`cat /sys/bus/iio/devices/iio\:device1/in_accel_y_raw`
z=`cat /sys/bus/iio/devices/iio\:device1/in_accel_z_raw`
echo "scale:"$scale" x:"$x" y:"$y" z:"$z
sleep 0.5
done

