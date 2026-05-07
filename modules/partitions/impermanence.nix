{ inputs, ... }:{
  flake-file.inputs.impermanence.url  = "github:nix-community/impermanence";

  flake.aspects.impermanence.nixos = { config, lib, ... }: with lib; {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persistent" = {
      enable      = config._.impermanence;
      hideMounts  = true;    # hide the bind mounts from showing up as mounted drives in the file manager
      directories = config._.persistent.dirs;
      files       = config._.persistent.files;
    };
  };
}
