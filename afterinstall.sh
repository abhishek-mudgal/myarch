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

pacman -S sudo curl ppp netctl dialog wpa_supplicant networkmanager  \
          grub efibootmgr dosfstools os-prober    \
          vim nano curl wget vlc pulseaudio cheese hexchat telegram-desktop flashplugin pepper-flash   \
          virtualbox  virtualbox-guest-iso virtualbox-host-modules-arch   \
          gvfs gvfs-mtp gvfs-google gvfs-goa gvfs-afc gvfs-smb gvfs-gphoto2   \
          pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack    \
          htop gparted mtools xorg lightdm gedit bluez bluez-utils firefox   \
          intel-gmmlib intel-media-driver intel-tbb lib32-libva-intel-driver lib32-libva1-intel-driver lib32-vulkan-intel libva-intel-driver    \
          libva1-intel-driver vulkan-intel acpica beignet    \
          bumblebee mesa xf86-video-intel nvidia lib32-nvidia-utils bbswitch nvidia-utils nvidia-settings cuda   \
          ttf-ubuntu-font-family ubuntu-keyring    \
          gnome gtk-engine-murrine gtk-engines qtcreator
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

gpasswd -a abhishek bumblebee
gpasswd -a root bumblebee

systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable bumblebeed.service

visudo
