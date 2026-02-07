{ config, inputs, lib, pkgs, ... }:{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = lib.mkIf (config._.boot_loader == "lanzaboot") {
    environment.systemPackages = [
      pkgs.sbctl        # for debugging and troubleshooting secure boot
    ];

    boot.lanzaboote = {
      enable    = true; # replaces systemd-boot
      pkiBundle = "/var/lib/sbctl";
    };

    _.persistent.dirs = lib.mkIf config._.impermanence [ 
      "/var/lib/sbctl" 
    ];
  };
}
