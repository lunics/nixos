#!/usr/bin/env bash

usb_copy=$HOME/usb_copy
btrfs_uuid="f03d5303-948c-4842-934c-727cbc5039be"
  # f03d5303-948c-4842-934c-727cbc5039be"         san disk
  # 0543f662-b81a-484e-9c52-71b6142685b2          lexar
luks_uuid="luks-2590eb50-1395-4c41-955b-976a599e2a3f"
  # luks-2590eb50-1395-4c41-955b-976a599e2a3f     san disk
  # luks-e0db3d7d-e237-4883-82a7-7fdfea49e097     lexar

if [ "$(hostname)" = "nixos" ]; then
  usb_uncrypted=/run/media/lunics/$btrfs_uuid 
elif [ "$(hostname)" = "ILTP-014" ]; then
  usb_uncrypted=/run/media/root/$btrfs_uuid
fi

if [ -d "$usb_uncrypted" ]; then      # if usb correctly mounted then
  if [ "$1" = "usb-->laptop" ]; then
    sudo rsync -azh --progress --delete $usb_uncrypted/ $usb_copy && \
      echo -e "\nUSB synchronization succeed"
  elif [ "$1" = "laptop-->usb" ]; then
    sudo rsync -azh --progress --delete $usb_copy/ $usb_uncrypted && \
      echo -e "\nUSB synchronization succeed"
  elif [ "$1" = "laptop-->usb_nobrowser" ]; then
    sudo rsync -azh --progress --delete --exclude=firefox --exclude=zen $usb_copy/ $usb_uncrypted && \
      echo -e "\nUSB synchronization succeed"
  elif [ "$1" = "laptop-->usb_unmount" ]; then
    sudo rsync -azh --progress --delete $usb_copy/ $usb_uncrypted && \
      echo -e "\nUSB synchronization succeed"

    sudo udisksctl unmount -b /dev/mapper/$luks_uuid && \
      echo USB ejected
  fi
else
  echo USB NOT MOUNTED
fi
