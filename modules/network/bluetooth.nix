{
  flake.aspects.bluetooth = {
    nixos = { config, options, lib, pkgs, ... }:
    let
      mac-controller = "FE:ED:BA:BE:30:0${toString config._.machine-index}";

      # sops keeps its yaml keys in clear text, so the file tells which devices are stored
      sops-file = if (options ? sops) && options.sops.defaultSopsFile.isDefined
                  then builtins.readFile config.sops.defaultSopsFile
                  else "";

      stored   = device: lib.hasInfix device.mac sops-file;
      paired   = lib.filter stored config._.bluetooth-devices;
      unpaired = lib.filter (device: !(stored device)) config._.bluetooth-devices;
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

      warnings = map (device:
        "sops: no bluetooth secrets for device ${device.name} (${device.mac}), it will have to be paired by hand"
      ) unpaired;

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
      }) paired);

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
