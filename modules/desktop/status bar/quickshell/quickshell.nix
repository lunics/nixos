{
  flake.aspects.quickshell.homeManager = { config, lib, pkgs, ... }:{
    programs.quickshell = {
      enable       = true;
      package      = pkgs.quickshell;
      configs      = {};
      activeConfig = null;              # null = load the config at $XDG_CONFIG_HOME/quickshell
      systemd = {
        enable = true;
        target = "hyprland-session.target";     # default = config.wayland.systemd.target
      };
    };
  };
}
