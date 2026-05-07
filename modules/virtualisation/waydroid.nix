{
  flake.aspects.virtualisation.nixos = { config, ... }:{
    virtualisation.waydroid.enable = config._.waydroid;
  };
}
