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



pacman -Syyu

passwd
useradd -mg users -G wheel,storage,power -s /bin/bash abhishek
passwd abhishek
chage -d 0 abhishek

pacman -S sudo curl ppp netctl dialog wpa_supplicant networkmanager grub efibootmgr dosfstools os-prober vim nano curl wget vlc pulseaudio cheese pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack htop gparted mtools xorg-server xorg-xinit lightdm gedit deepin deepin-extra bluez bluez-utils firefox-developer-edition bumblebee mesa xf86-video-intel nvidia lib32-nvidia-utils bbswitch nvidia-utils nvidia-settings cuda
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

gpasswd -a abhishek bumblebee
gpasswd -a root bumblebee

systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable bumblebeed.service

echo "" >> /etc/pacman.conf
echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf

visudo
