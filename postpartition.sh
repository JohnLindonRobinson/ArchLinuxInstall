echo """Welcome back to the Install, I hope you partitioned alright"""
nkfs.fat -F32 /dev/sda1
nkfs.fat -F32 /dev/vda1
mkswap /dev/sda2
mkswap /dev/vda2
swapon /dev/sda2
swapon /dev/vda2
mkfs.btrfs /dev/sda3
mkfs.btrfs /dev/vda3

mount /dev/sda3 /mnt
mount /dev/vda3 /mnt
pacstrap /mnt base linux linux-firmware


genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
pacman -S sudo grub efibootmgr dosfstools os-prover mtools

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime/
hwclock --systohc

sed -i 's/#en_GB.UTF/en_GB.UTF/' /etc/locale.gen
locale-gen

echo """Choose hostname"""
read hostname; echo $hostname > /etc/hostname
echo -e "\n127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$hostname.localdomain \t$hostname" >> /etc/hosts

passwd
useradd -m johnny
passwd johnny
usermod -aG wheel,audiomvideo,optical,storage johnny
sed -i 's/# %wheel ALL=(ALL) ALL/ %wheel ALL=(ALL) ALL/' /etc/sudoers

mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
mount /dev/vda1 /boot/EFI

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
