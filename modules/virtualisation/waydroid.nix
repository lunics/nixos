{
  flake.aspects.waydroid.nixos = { config, lib, ... }:{
    virtualisation.waydroid.enable = config._.waydroid;

    _.persistent-system.dirs = lib.mkIf config._.waydroid [
      "/var/lib/waydroid"    # android images and the session data
    ];
  };
}
