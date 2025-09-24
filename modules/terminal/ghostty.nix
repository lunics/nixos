{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.terminal == "ghostty") {
    home.packages = with pkgs; [
      ghostty
    ];

    xdg.configFile."ghostty/config".text = ''
      font-family             = "Ubuntu Mono:style=Regular"
      font-size               = 23
      background-opacity      = 0.7
      background              = #1f1f1f
      # background-blur       = 20
      mouse-hide-while-typing = false
      shell-integration       = zsh
      window-new-tab-position = current
      focus-follows-mouse     = false
      copy-on-select          = true
      linux-cgroup            = always
      desktop-notifications   = true
      keybind                 = alt+c=copy_to_clipboard
      keybind                 = alt+v=paste_from_clipboard
      initial-command         = restore_tmux
    '';
      # KO initial-command       = "tmux && ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh"
  };
}
