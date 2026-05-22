{
  flake.aspects.waydroid.nixos = { config, ... }:{
    virtualisation.waydroid.enable = config._.waydroid;
  };
}
