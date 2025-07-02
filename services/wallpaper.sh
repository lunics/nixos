#!/usr/bin/env bash

# source /home/${UID}/.nix-profile/etc/profile.d/hm-session-vars.sh

path_wallpapers="/home/lunics/usb_copy/homelab/share/wallpapers"

max_wallpapers=$(ls -1 $path_wallpapers | wc -l)

num_wallpaper=$(shuf -i 0-${max_wallpapers} -n 1)

selected_wallpaper=$(ls -1 $path_wallpapers | sed -n "${num_wallpaper}p")

swww init
swww img $1 --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 3
