mkfs.ubifs -m 2048 -e 124KiB -c 1734 -r host_stream_ar0544/ -F -o ar0544.img
ubinize -o ubifs.img -m 2048 -p 128KiB -s 512 -O 2048 ubinize.cfg
