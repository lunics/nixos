_run_pass() {
  $HOME/.nix-profile/bin/passfzf
  zle reset-prompt    # needed to avoid press enter to exit subshell
}
