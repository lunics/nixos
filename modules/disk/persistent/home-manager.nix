{
  flake.aspects.persistent.nixos = { config, lib, ... }:
  let
    _ = config._;
  in {
    config = lib.mkIf _.persistent-home.ephemeral-btrfs {
      # standalone home-manager keeps its generations in the home, they must outlive the wipe
      preservation.preserveAt.${_.persistent-system.dest}.users.${_.user}.directories = [
        ".local/state/nix"             # profiles, home-manager generations included
        ".local/state/home-manager"    # gcroots of the current generation
      ];
    };
  };
}
