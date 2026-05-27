{
  flake.aspects.bluetooth = {
    nixos = { config, lib, ... }:{
      hardware.bluetooth = {
        enable      = true;
        powerOnBoot = true;
        settings = {
          General.Experimental = true;
        };
      };

      services.blueman.enable = true;   # GTK+ bluetooth manager

      _.persistent.dirs = lib.mkIf config._.impermanence [
        "/var/lib/bluetooth"
      ];
    };

    homeManager = { lib, ... }:{
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "simpledbus"    # lib of SimpleBLE as a wrapper of libdbus-1
        "simplebluez"
      ];
    };
  };
}
