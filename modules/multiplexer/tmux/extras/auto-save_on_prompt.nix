{ pkgs, ... }:{
 # save tmux sessions every time the prompt is updated
  programs.zsh.initContent = ''
    precmd() {
      if [[ -n "$TMUX" ]]; then
        eval "$(tmux show-environment -s)"
        setsid ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh quiet
      fi
    }
  '';
}
