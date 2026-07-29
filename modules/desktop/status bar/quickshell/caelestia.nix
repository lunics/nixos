{ inputs, ... }:{
  flake-file.inputs.caelestia-shell = {
    url = "github:caelestia-dots/shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.caelestia.homeManager = { config, lib, pkgs, ... }:{
    imports = [ inputs.caelestia-shell.homeManagerModules.default ];

    programs.caelestia = {
      enable  = true;
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

    xdg.desktopEntries."org.quickshell" = {
      name = "Quickshell";
      exec = "qs";
      type = "Application";
    };
  };
}
