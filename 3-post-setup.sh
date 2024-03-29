#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
   d8b 888b    888          888                              .d88888b.   .d8888b.  
   Y8P 8888b   888          888                             d88P" "Y88b d88P  Y88b 
       88888b  888          888                             888     888 Y88b.      
   888 888Y88b 888  8888b.  888888 888  888 888d888 .d88b.  888     888  "Y888b.   
   888 888 Y88b888     "88b 888    888  888 888P"  d8P  Y8b 888     888     "Y88b. 
   888 888  Y88888 .d888888 888    888  888 888    88888888 888     888       "888 
   888 888   Y8888 888  888 Y88b.  Y88b 888 888    Y8b.     Y88b. .d88P Y88b  d88P 
   888 888    Y888 "Y888888  "Y888  "Y88888 888     "Y8888   "Y88888P"   "Y8888P"
-------------------------------------------------------------------------
                    Automated iNatureOS Installer
                        SCRIPTHOME: iNatureOS
-------------------------------------------------------------------------

Final Setup and Configurations
GRUB EFI Bootloader Install & Check
"
source /root/iNatureOS/setup.conf
genfstab -U / >> /etc/fstab
if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi
# set kernel parameter for decrypting the drive
if [[ "${FS}" == "luks" ]]; then
sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${encryped_partition_uuid}:ROOT root=/dev/mapper/ROOT %g" /etc/default/grub
fi

echo -e "Installing CyberRe Grub theme..."
THEME_DIR="/boot/grub/themes"
THEME_NAME=CyberRe
echo -e "Creating the theme directory..."
mkdir -p "${THEME_DIR}/${THEME_NAME}"
echo -e "Copying the theme..."
cd ${HOME}/iNatureOS
cp -a ${THEME_NAME}/* ${THEME_DIR}/${THEME_NAME}
echo -e "Backing up Grub config..."
cp -an /etc/default/grub /etc/default/grub.bak
echo -e "Setting the theme as the default..."
grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
echo -e "Updating grub..."
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"

echo -ne "
-------------------------------------------------------------------------
                    Enabling Login Display Manager
-------------------------------------------------------------------------
"
systemctl enable sddm.service
echo -ne "
-------------------------------------------------------------------------
                    Setting up lightdm Theme
-------------------------------------------------------------------------
"
cat <<EOF > /etc/sddm.conf
[Theme]
Current=Nordic
EOF
echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"
systemctl disable dhcpcd.service
systemctl stop dhcpcd.service
systemctl enable NetworkManager.service
echo -ne "
-------------------------------------------------------------------------
                    Cleaning 
-------------------------------------------------------------------------
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

rm -r /root/iNatureOS
rm -r /home/$USERNAME/iNatureOS

# Replace in the same state
cd $pwd
