{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.terminal == "ghostty") {
    home.packages = with pkgs; [
      ghostty
    ];

    xdg.configFile."ghostty/config".text = ''
      font-size               = 20
      background-opacity      = 0.8
      background-blur         = 50
      mouse-hide-while-typing = false
      shell-integration       = zsh
      window-new-tab-position = current
      focus-follows-mouse     = false
      copy-on-select          = true
      linux-cgroup            = always
      desktop-notifications   = true
      keybind                 = alt+c=copy_to_clipboard
      keybind                 = alt+v=paste_from_clipboard
      initial-command         = tmux
    '';
  };
}
