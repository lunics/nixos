{ pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ {
    plugin = resurrect;
    extraConfig = ''
      set -g @resurrect-capture-pane-contents "on"
      set -g @resurrect-strategy-nvim "session"
      # set -g @resurrect-save          "S"         already set in binds with M-C-s
      # set -g @resurrect-restore       "R"         NOT SET
      set -g @resurrect-dir           "$HOME/usb_copy/homelab/share/tmux"   # only $HOME and ~ are enabled
    '';
  } ];
}
