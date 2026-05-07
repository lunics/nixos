{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib; {
    config = mkMerge [{
      fileSystems = {
        "/nix".neededForBoot        = true;
        "/var/log".neededForBoot    = true;
      };
    }(mkIf config._.impermanence {
      fileSystems."/persistent".neededForBoot = true;
    })];
  };
}
