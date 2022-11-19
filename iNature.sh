#!/bin/bash

# Find the name of the folder the scripts are in
setfont ter-v22b
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
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
-------------------------------------------------------------------------
                Scripts are in directory named iNatureOS
"
    bash startup.sh
    source $SCRIPT_DIR/setup.conf
    bash 0-preinstall.sh
    arch-chroot /mnt /root/iNatureOS/1-setup.sh
    arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/iNatureOS/2-user.sh
    arch-chroot /mnt /root/iNatureOS/3-post-setup.sh

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
-------------------------------------------------------------------------
                Done - Please Eject Install Media and Reboot
"
