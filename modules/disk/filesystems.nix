{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib; {
    fileSystems = {
      "/nix".neededForBoot     = true;
      "/var/log".neededForBoot = true;
    };
  };
}
