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
zle -N _open_yazi
bindkey '^I' _open_yazi     # IF tab pressed when prompt is empty THEN run yazi

bindkey "^[^?" backward-kill-word       # alt backspace = delete word before
