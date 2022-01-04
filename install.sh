echo """Welcome to Johnny's Arch Linux install Script
I hope you enjoy your stay"""
chmod +x *.sh
loadkeys /usr/share/kbd/keymaps/i386/qwerty/uki.map.gz
timedatectl set-ntp true
ping google.com
fdisk -l
echo """Now partition the disks using fdisk and the appropriate drive as listed earlier <3, then run PostPartition.sh"""
