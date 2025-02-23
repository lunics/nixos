#!/usr/bin/env bash

usb_copy=$HOME/usb_copy

if [ "$(hostname)" = "nixos" ]; then
  usb_uncrypted=/run/media/lunics/0543f662-b81a-484e-9c52-71b6142685b2
elif [ "$(hostname)" = "ILTP-014" ]; then
  usb_uncrypted=/run/media/root/0543f662-b81a-484e-9c52-71b6142685b2
fi

if [ -d "$usb_uncrypted" ]; then
  sudo rsync -azh --progress --delete $usb_copy/ $usb_uncrypted && \
    echo USB synchronization succeed

  sudo udisksctl unmount -b /dev/mapper/luks-e0db3d7d-e237-4883-82a7-7fdfea49e097 && \
    echo USB ejected
else
  echo USB NOT MOUNTED
fi
