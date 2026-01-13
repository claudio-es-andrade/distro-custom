#!/bin/bash

echo "Step1: Installing the required tools"
apt update
apt install -y debootstrap squashfs-tools xorriso isolinux syslinux-utils

echo "Step2: Create a directoy for the Chroot Environment"
mkdir - p /mnt/trixie

echo "Creating the CHROOT_DIR variable inside of /mnt directory"
CHROOT_DIR="/mnt/trixie"

echo "Step3: Bootstrap a minimal Debian System"
debootstrap trixie $CHROOT_DIR https://deb.debian.org/debian

echo "Step4: Mount Essential Filesystems"
echo "Mounting the proc, sys, dev, run of the mounting parts and also making a copy of the resolv.conf to there"
mount --types proc /proc $CHROOT_DIR/proc
mount --rbind /sys $CHROOT_DIR/sys
mount --rbind /dev $CHROOT_DIR/dev
mount --bind /run $CHROOT_DIR/run

cp /etc/resolv.conf $CHROOT_DIR/etc/resolv.conf
cp live_build_All.sh $CHROOT_DIR/    # Build the live image
cp core_and_Desktops.sh $CHROOT_DIR/           # Files and desktops included   
cp -R calamares-settings-debian/ $CHROOT_DIR/  # https://salsa.debian.org/live-team/calamares-settings-debian
cp splash.png $CHROOT_DIR/                     # Backgroud Image type PNG with 680 X 480 


echo "Step5: Aplying the CHROOT command"
echo "# export PS1='(debian_chroot) ${PS1}' "
chroot $CHROOT_DIR /bin/bash
