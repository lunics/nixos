{
  flake.aspects.services.nixos = { config, pkgs, ... }:{
    services.fwupd = {
      enable  = false;
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
  };
}
