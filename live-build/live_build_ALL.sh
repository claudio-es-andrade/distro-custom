#!/bin/bash
# Creating a custom Debian ISO

# 1. Update Your System
echo "Updating the system ..."
apt update
apt upgrade -y

# 2. Install Required Packages
echo "Installing the required packages"
apt install -y live-build debootstrap squashfs-tools xorriso isolinux syslinux-utils

# 3. Set Up the Working Directory
echo "Set Up the Working Directory"
mkdir debian_custom_iso
cd debian_custom_iso

# 4. Configure the Build Environment
echo "Configure the Build Environment"

lb config \
  --distribution trixie \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer live \
  --bootappend-live \
     "boot=live components timezone=America/Sao_Paulo locales=pt_BR.UTF-8 keyboard-layouts=br keyboard-variants=abnt2"

# 5. Add Custom Packages

read -p "Digite enter para continuar"
echo "Adding Custom Packages and choosing the Desktop"
bash /mnt/trixie/cores_and_Desktops.sh

# 6. Adding menu and new background 

read -p "Digite enter para continuar"
mkdir -p  config/bootloaders/isolinux
cp /mnt/trixie/splash.png config/bootloaders/isolinux/splash.png

cat <<EOF >>  config/bootloaders/isolinux/isolinux.cfg
include menu.cfg
default vesamenu.c32
prompt 0
timeout 0

EOF

# 7. Adding Calamares installer (Optional)

read -p "Digite enter para continuar"
echo "Adding Calamares installer (Optional)"
mkdir -p config/includes.chroot/etc
cp -R /mnt/trixie/calamares-settings-debian  config/includes.chroot/etc

# 8. Add Preseed Configuration (Optional)
echo "Add Preseed Configuration (Optional)"
mkdir -p config/includes.installer
cat << EOF >> config/includes.installer/preseed.cfg
d-i debian-installer/locale string pt_BR
d-i console-setup/ask_detect boolean false
d-i console-tools/archs select at
d-i console-keymaps-at/keymap select br
d-i keyboard-configuration/xkb-keymap select br
EOF

# 9. Include Custom Files
echo "Include Custom Files"
mkdir -p config/includes.chroot/etc/skel
echo "Welcome to my custom Debian ISO!" > config/includes.chroot/etc/skel/README

# 10. Add hooks for Custom Scripts
echo "Add hooks for Custom Scripts"
mkdir -p config/hooks/live

cat <<EOF >> config/hooks/live/0001-custom.hook.chroot
#!/bin/bash
echo "Running custom setup ..."
extrepo enable mozilla
extrepo enable vscode
extrepo enable waydroid
extrepo enable brave
extrepo enable docker-ce
extrepo enable google_chrome
extrepo enable virtualbox
apt update
apt remove -y firefox-esr
apt upgrade -y
apt install -y  firefox
apt install -y vlc 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
systemctl enable ufw
ufw enable

EOF

chmod +x config/hooks/live/0001-custom.hook.chroot

# 11. Build the ISO Image
echo "Build the ISO Image ..."
lb build

# 12. Cleaning the build Environment
#echo "Cleaning the build Environment"
#lb clean
