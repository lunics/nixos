{
  flake.aspects.quickshell.homeManager = { config, lib, pkgs, ... }:{
    programs.quickshell = {
      enable       = true;
      package      = pkgs.quickshell;
      configs      = {};
      activeConfig = null;    # name of the config to use
                              # null = try to use config located at $XDG_CONFIG_HOME/quickshell
      systemd = {
        enable = true;
        target = "hyprland-session.target";     # default = config.wayland.systemd.target
      };
    };

    xdg.configFile."quickshell/shell.qml".source = ./shell.qml;
  };
}
