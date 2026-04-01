{ config, pkgs, ... }: {
  services.fwupd = {
    enable  = true;
    package = pkgs.fwupd;
    daemonSettings = {
      EspLocation     = config.boot.loader.efi.efiSysMountPoint;
      DisabledDevices = [];
      DisabledPlugins = [];
    };
    extraRemotes        = [];
    extraTrustedKeys    = [];
    uefiCapsuleSettings = {};
  };
}
