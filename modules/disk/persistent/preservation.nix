{ inputs, ... }:{
  flake-file.inputs.preservation.url  = "github:nix-community/preservation";

  flake.aspects.persistent.nixos = { config, lib, ... }: with lib; {
    imports = [ inputs.preservation.nixosModules.default ];

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
