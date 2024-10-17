_open_all (){
  local target=
  target=$(find ~/ -path '*/\.*' -prune -o \( -type d -o -type f -o -type l \) -print 2> /dev/null | fzf)

  [ -f ${target} ] && $EDITOR ${target}
  [ -d ${target} ] && ranger ${target} < $TTY
  zle reset-prompt
}
