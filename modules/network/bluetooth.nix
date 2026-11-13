{
  flake.aspects.bluetooth = {
    nixos = { config, pkgs, ... }:
    let
      mac-controller = "FE:ED:BA:BE:30:0${toString config._.machine-index}";
    in {
      hardware.bluetooth = {
        enable      = true;
        powerOnBoot = true;
        settings = {
          General.Experimental = true;
        };
      };

      systemd.services.bluetooth.serviceConfig.ExecStartPre = [
        "${pkgs.bluez}/bin/hciconfig hci0 down"
        "${pkgs.bluez}/bin/btmgmt --index 0 public-addr ${mac-controller}"
        "${pkgs.bluez}/bin/hciconfig hci0 up"
      ];

      services.blueman.enable = true;   # GTK+ bluetooth manager

      # bluez rewrites info and attributes while running, so the pairings are persisted, never deployed as secrets
      _.persistent-system.dirs = [
        { directory = "/var/lib/bluetooth"; mode = "0700"; }    # holds the link keys, bluez keeps it root only
      ];
    };
  };
}
