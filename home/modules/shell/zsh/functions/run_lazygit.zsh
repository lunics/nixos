_run_lazygit() {
  $HOME/.nix-profile/bin/lazygit
  zle reset-prompt    # needed to avoid press enter to exit subshell
}
