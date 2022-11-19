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

Installing AUR Softwares
"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.
source $HOME/iNatureOS/setup.conf

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~

yay -S --noconfirm --needed - < ~/iNatureOS/pkg-files/aur-pkgs.txt

export PATH=$PATH:~/.local/bin

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
