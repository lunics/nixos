{ inputs, ... }:{
  flake-file.inputs.preservation.url  = "github:nix-community/preservation";

  flake.aspects.persistent.nixos = { config, ... }:{
    imports = [ inputs.preservation.nixosModules.default ];

    preservation = {
      enable = true;
      preserveAt.${config._.persistent-system.dest} = {
        files       = config._.persistent-system.files;
        directories = config._.persistent-system.dirs;
      };
    };

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
