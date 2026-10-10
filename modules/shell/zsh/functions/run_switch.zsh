_run_switch() {
  local target
  target=$(print -l home-manager nixos | fzf --height 20% --reverse --no-multi --prompt 'switch> ')

  if [[ -n $target ]]; then
    [[ $target == home-manager ]] && target=hm
    $HOME/.nix-profile/bin/switch $target
  fi

  zle reset-prompt    # needed to avoid press enter to exit subshell
}
