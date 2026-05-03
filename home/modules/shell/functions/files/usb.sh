#!/usr/bin/env bash

usb (){
  usb_path="/run/media/$USER"
  if [ "$(ls -1 $usb_path | wc -l)" = 1 ]; then
    c $usb_path/$(ls $usb_path)
    # exec zsh -l   # when from .local/bin
    # [ $0 = "zsh" ] && zsh -c "exec -a -zsh zsh"
  else
    c $usb_path
    # exec zsh -l  # when from .local/bin
    # [ $0 = "zsh" ] && zsh -c "exec -a -zsh zsh"
  fi
}
