#!/bin/bash

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 50 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3
mk.ext4 /dev/sda4
mkswap /dev/sda2

mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
swapon /dev/sda2

echo "" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacstrap /mnt base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

arch-chroot /mnt
echo "OPTIMUS" > /etc/hostname
echo "en_IN UTF-8" >> /etc/locale.gen

locale-gen
echo LANG=en_IN.UTF-8 > /etc/locale.conf
export LANG=en_IN.UTF-8
ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc --utc

echo "" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

echo "" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf

pacman -Syyu

passwd
useradd -mg users -G wheel,storage,power -s /bin/bash abhishek
passwd abhishek
chage -d 0 abhishek

pacman -S sudo curl ppp netctl dialog wpa_supplicant networkmanager grub efibootmgr dosfstools os-prober mtools yaourt xorg-server xorg-xinit xf86-video-intel lightdm lightdm-gtk-greeter xfce4 xfce4-goodies network-manager-applet firefox-developer-edition
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable lightdm
systemctl enable NetworkManager


echo "Edit the sudoers file"
