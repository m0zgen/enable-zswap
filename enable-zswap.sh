#!/bin/bash
# Enable zswap on the Fedora
# Created by Yevgeniy Goncharov, https://sys-adm.in
# Official Fedora doc - https://fedoraproject.org/wiki/Zswap
# How to check working zswap - https://unix.stackexchange.com/questions/406936/get-current-zswap-memory-usage-and-statistics

# Enable lz4 kernel support
modprobe lz4 lz4_compress
echo "add_drivers+=\"lz4 lz4_compress\"" >> /etc/dracut.conf.d/lz4.conf

# Regenerate all of your initramfs images
dracut --regenerate-all --force

# Permanently enabling zswap from Grub
sed -i 's/GRUB_CMDLINE_LINUX="[^"]*/& zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4/' /etc/default/grub

# Update grub
grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Please reboot your computer!"
