{
  flake.aspects.bluetooth = {
    nixos = { config, lib, pkgs, ... }:
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

      systemd.services.bluetooth = {
        serviceConfig = {
          ExecStartPre = [
            "${pkgs.bluez}/bin/hciconfig hci0 down"
            "${pkgs.bluez}/bin/btmgmt --index 0 public-addr ${mac-controller}"
            "${pkgs.bluez}/bin/hciconfig hci0 up"
          ];
        };
      };

      assertions = map (device: {
        assertion = (config.sops.secrets ? "${device.mac}/info")
                 && (config.sops.secrets ? "${device.mac}/attributes");
        message   = "sops: missing bluetooth secrets for device ${device.name} (${device.mac})";
      }) config._.bluetooth-devices;

      sops.secrets = lib.mkMerge (map (device: {
        "${device.mac}/info" = {
          path         = "/var/lib/bluetooth/${mac-controller}/${device.mac}/info";
          mode         = "0600";
          restartUnits = [ "bluetooth.service" ];
        };
        "${device.mac}/attributes" = {
          path         = "/var/lib/bluetooth/${mac-controller}/${device.mac}/attributes";
          mode         = "0600";
          restartUnits = [ "bluetooth.service" ];
        };
      }) config._.bluetooth-devices);

      services.blueman.enable = true;   # GTK+ bluetooth manager

      _.persistent-system.dirs = [
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
