_open_all (){
  local target=
  target=$(find $HOME/usb_copy -path '*/\.*' -prune -o \( -type d -o -type f -o -type l \) -print 2> /dev/null | fzf)

  if [ -f "${target}" ]; then 
    $EDITOR ${target}
  elif [ -d "${target}" ]; then
    zoxide add "$(realpath ${target})"
    $FILE_EXPLORER ${target} < $TTY
    zle reset-prompt                ## mettre en dehors du IF ?
  fi
}
