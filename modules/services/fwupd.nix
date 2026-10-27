{
  flake.aspects.fwupd.nixos = { config, lib, pkgs, ... }:{
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

    _.persistent-system.dirs = lib.mkIf config.services.fwupd.enable [
      "/var/lib/fwupd"    # device history and the enabled remotes
    ];
  };
}
