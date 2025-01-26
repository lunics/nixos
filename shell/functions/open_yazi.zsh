_open_yazi() {
  if [[ $#BUFFER == 0 ]]; then
    yazi < $TTY
    # KO
    # LASTDIR=$(cat /tmp/yazi_save_dir)
    # cd "$LASTDIR"
    zle reset-prompt
  else
    zle expand-or-complete
  fi
}
