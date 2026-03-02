_run_zoxide() {
  # zi < $TTY       # run zoxide, v1
  zoxide query -l | fzf --height 40% --reverse
  $FILE_EXPLORER    # run yazi
  zle reset-prompt
}
