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

      assertions = map (mac-device: {
        assertion = (config.sops.secrets ? "${mac-device}/info")
                 && (config.sops.secrets ? "${mac-device}/attributes");
        message   = "sops: missing bluetooth secrets for device ${mac-device}";
      }) config._.bluetooth-devices;

      sops.secrets = lib.mkMerge (map (mac-device: {
        "${mac-device}/info" = {
          path         = "/var/lib/bluetooth/${mac-controller}/${mac-device}/info";
          mode         = "0600";
          restartUnits = [ "bluetooth.service" ];
        };
        "${mac-device}/attributes" = {
          path         = "/var/lib/bluetooth/${mac-controller}/${mac-device}/attributes";
          mode         = "0600";
          restartUnits = [ "bluetooth.service" ];
        };
      }) config._.bluetooth-devices);

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
