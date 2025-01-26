_open_all (){
  local target=
  target=$(find ${USB}/${USB_ID} -path '*/\.*' -prune -o \( -type d -o -type f -o -type l \) -print 2> /dev/null | fzf)

  [ -f ${target} ] && $EDITOR ${target}
  [ -d ${target} ] && $FILE_EXPLORER ${target} < $TTY
  zle reset-prompt
}
