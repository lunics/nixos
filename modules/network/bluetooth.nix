{
  flake.aspects.bluetooth = {
    nixos = { config, lib, pkgs, ... }:{
      hardware.bluetooth = {
        enable      = true;
        powerOnBoot = true;
        settings = {
          General.Experimental = true;
        };
      };

      systemd.services.bluetooth = {
        serviceConfig = {
          ExecStartPre = [
            "${pkgs.bluez}/bin/hciconfig hci0 down"
            "${pkgs.bluez}/bin/btmgmt --index 0 public-addr FE:ED:BA:BE:30:0${toString config._.machine-index}"
            "${pkgs.bluez}/bin/hciconfig hci0 up"
          ];
        };
      };

      services.blueman.enable = true;   # GTK+ bluetooth manager

      _.persistent.dirs = lib.mkIf config._.impermanence [
        "/var/lib/bluetooth"
      ];
    };

    homeManager = { pkgs, ... }:{
      _.allow-unfree = with pkgs; [ 
        simpledbus    # lib of SimpleBLE as a wrapper of libdbus-1
        simplebluez
      ];
    };
  };
}
