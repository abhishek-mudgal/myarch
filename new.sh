#!/bin/bash



wget https://raw.githubusercontent.com/abhishek9650/myarch/master/afterinstall.sh

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3

mkswap /dev/sda2

mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
rm -rf /mnt/home/abhishek/.*
swapon /dev/sda2

echo "" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacstrap /mnt base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

cp afterinstall.sh /mnt/
arch-chroot /mnt
