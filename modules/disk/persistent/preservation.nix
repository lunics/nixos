{ inputs, ... }:{
  flake-file.inputs.preservation.url  = "github:nix-community/preservation";

  flake.aspects.persistent.nixos = { config, lib, ... }: with lib; {
    imports = [ inputs.preservation.nixosModules.default ];

    # /var/log and /snapshots are btrfs subvolumes of their own, they must not be bind mounted over
    _.persistent-system = {
      dirs = [
        "/var/lib/nixos"      # uid and gid maps, what keeps the users stable across a wipe
        "/var/lib/systemd"    # machine credentials, random seed, persistent timers, backlight, rfkill
      ];
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
      ];
    };

    preservation = {
      enable = config._.persistent;
      preserveAt.${config._.persistent-system.dest} = {
        files       = config._.persistent-system.files;
        directories = config._.persistent-system.dirs;
      };
    };

    fileSystems."${config._.persistent-system.dest}".neededForBoot = true;

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
