#!/bin/bash

echo "Welcome to the Arch Linux Installer!"

# Continually ask for a partition or disk until a valid one is provided
while true; do
    # Display available disks and partitions
    echo "Available disks and partitions:"
    lsblk

    # Get user input
    read -p "Enter the partition/disk where Arch Linux should be installed (e.g., /dev/sda1): " target

    # Check if the entered partition/disk exists
    if [ -b "$target" ]; then
        # Proceed with the installation
        echo "Installing Arch Linux on $target..."

        # Assuming you've already prepared the partition (formatted and mounted)
        # Otherwise, you'd need to add those steps here

        # Install the base system
        pacstrap /mnt base linux linux-firmware

        # Generate fstab
        genfstab -U /mnt >> /mnt/etc/fstab

        # Set timezone
        arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
        arch-chroot /mnt hwclock --systohc

        # Here, you would continue the usual Arch Linux installation steps, such as setting the locale, hosts, etc.

        # Install GNOME
        arch-chroot /mnt pacman -S gnome

        # Enable GDM (Gnome Display Manager) for start on boot
        arch-chroot /mnt systemctl enable gdm

        echo "Installation completed! Please reboot your machine."
        break
    else
        echo "Not a real disk, try again!"
    fi
done
