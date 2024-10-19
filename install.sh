#!/bin/bash

# Selection Menu for Ubuntu Version
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=2
BACKTITLE="Ubuntu Setup"
TITLE="Ubuntu Version Installer"
MENU="Choose your preferred Ubuntu version:"

OPTIONS=(1 "Ubuntu 20.04"
         2 "Ubuntu 22.04")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
# Based on user selection, set the Ubuntu version
case $CHOICE in
    1)
        UBUNTU_VERSION="20.04"
        UBUNTU_IMAGE="ubuntu20"
        ;;
    2)
        UBUNTU_VERSION="22.04"
        UBUNTU_IMAGE="ubuntu22"
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Password Input and Confirmation
while true; do
    read -sp "Enter root password: " root_password
    echo
    read -sp "Confirm root password: " root_password_confirm
    echo

    if [ "$root_password" == "$root_password_confirm" ]; then
        echo "Passwords match!"
        break
    else
        echo "Passwords do not match, please try again."
    fi
done

# Set the root password securely
echo "Setting root password..."
echo "root:$root_password" | chpasswd

# Installation Process
echo "Starting installation of Ubuntu $UBUNTU_VERSION..."

# Pull the correct Ubuntu version and configure it
if [ "$UBUNTU_VERSION" == "20.04" ]; then
    echo "Pulling Ubuntu 20.04 image..."
    docker pull ubuntu:20.04
elif [ "$UBUNTU_VERSION" == "22.04" ]; then
    echo "Pulling Ubuntu 22.04 image..."
    docker pull ubuntu:22.04
fi

# Restart the server after installation
echo "Restarting the server..."
shutdown -r now
