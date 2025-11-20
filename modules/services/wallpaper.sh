#!/usr/bin/env bash

# source /home/${UID}/.nix-profile/etc/profile.d/hm-session-vars.sh

path_wallpapers="/home/$USER/usb_copy/homelab/share/wallpapers"

max_wallpapers=$(ls -1 $path_wallpapers | wc -l)

# swww query 
#   /home/lunics/usb_copy/homelab/share/wallpapers/summer-anime-girl-cat-4k-wallpaper-uhdpaper.com-414@5@d.jpg

selected_line=$(shuf -i 0-${max_wallpapers} -n 1)

selected_wallpaper=$(ls -1 $path_wallpapers | sed -n "${selected_line}p")

echo "Wallpaper name: $selected_wallpaper"

swww img "$path_wallpapers/$selected_wallpaper" --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 3 --invert-y
