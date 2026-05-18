{ inputs, ... }:{
  flake-file.inputs.preservation.url  = "github:nix-community/preservation";

  flake.aspects.preservation.nixos = { config, lib, ... }: with lib; {
    imports = [ inputs.preservation.nixosModules.default ];

    preservation = {
      enable = config._.preservation;
      preserveAt."/persistent" = {
        files = [
          { file = "/etc/machine-id"; inInitrd = true; }
        ];
        directories = config._.persistent.dirs;
      };
    };

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
