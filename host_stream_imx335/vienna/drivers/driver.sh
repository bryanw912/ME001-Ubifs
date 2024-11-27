#!/bin/sh

insmod vpl_edmc_v6.3.0.2.ko
insmod vpl_dmac_v2.0.0.3.ko
insmod vma_ifpe_v1.1.0.0.ko
insmod vma_jdbe_v2.0.0.1.ko
insmod vma_jebe_v2.0.0.1.ko
insmod vma_ispe_v2.0.0.5.ko
insmod vma_h4cde_v2.0.0.8.ko
insmod vma_meae_v2.0.0.0.ko
insmod vma_rs_v2.0.0.4.ko
insmod vma_dce_v2.0.0.4.ko

insmod vpl_voc_v2.2.0.0.ko
insmod it66121enc_v1.0.0.3.ko
echo 1920x1080 > /sys/class/vpl_voc/curt_mode

sh ./vma_h5cde.sh
sh sensor.sh
