{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.status_bar == "quickshell") {
    programs.quickshell = {
      enable       = true;
      package      = pkgs.quickshell;
      configs      = {};
      activeConfig = null;    # name of the config to use
                              # will try to use a config located in $XDG_CONFIG_HOME/quickshell instead of one of the named sub-directories
      systemd = {
        enable = true;
        target = "hyprland-session.target";     # default = config.wayland.systemd.target
      };
    };
  };
}
