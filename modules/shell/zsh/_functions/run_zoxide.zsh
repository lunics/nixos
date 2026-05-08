_run_zoxide() {
  # zi < $TTY               # run zoxide, v1

  local dir

  dir=$(zoxide query -l | fzf --height 40% --reverse)   # v2

  if [[ -z "$dir" ]]; then  # exit function if zoxide interputed
    zle reset-prompt
    return 
  else
    cd "$dir" 
    $FILE_EXPLORER          # run yazi
  fi

  zle reset-prompt
}
