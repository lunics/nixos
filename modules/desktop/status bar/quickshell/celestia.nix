{
  flake-file.inputs.caelestia-shell = {
    url = "github:caelestia-dots/shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.status_bar.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf (config._.status_bar == "quickshell") {
      programs.caelestia = {
        enable = true;
        systemd = {
          enable      = true;
          target      = "graphical-session.target";
          environment = [];
        };
        settings = {
          bar.status = {
            showBattery = true;
          };
          paths.wallpaperDir = "${config._.share}/wallpapers";
        };
        cli = {
          enable = true;    # add caelestia-cli to path
          settings = {
            theme.enableGtk = false;
          };
        };
      }; 
    };
  };
}
