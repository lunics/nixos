_open_all (){
  local target=
  # target=$(find ${USB}/${USB_ID} -path '*/\.*' -prune -o \( -type d -o -type f -o -type l \) -print 2> /dev/null | fzf)
  target=$(find /mnt/usb_drive -path '*/\.*' -prune -o \( -type d -o -type f -o -type l \) -print 2> /dev/null | fzf)

  if [ -f ${target} ]; then 
    $EDITOR ${target}
  elif [ -d ${target} ]; then
    $FILE_EXPLORER ${target} < $TTY
    zoxide add $(realpath ${target})
    zle reset-prompt                ## mettre en dehors du IF ?
  fi
}
