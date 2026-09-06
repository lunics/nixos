{ inputs, ... }:{
  flake-file.inputs.preservation.url  = "github:nix-community/preservation";

  flake.aspects.persistent.nixos = { config, lib, ... }: with lib; {
    imports = [ inputs.preservation.nixosModules.default ];

    preservation = {
      enable = config._.persistent;
      preserveAt.${config._.persistent-system.dest} = {
        files = [
          { file = "/etc/machine-id"; inInitrd = true; }
        ];
        directories = config._.persistent-system.dirs;
      };
    };

    fileSystems."${config._.persistent-system.dest}".neededForBoot = true;

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
