{ inputs, ... }:{
  flake-file.inputs.impermanence.url  = "github:nix-community/impermanence";

  # kept as a reference, persistent relies on preservation
  flake.aspects.impermanence = {
    # the nixos module stays mandatory: it injects the home-manager one and owns the bind mounts
    nixos = {
      imports = [ inputs.impermanence.nixosModules.impermanence ];
    };

    homeManager = { config, ... }:{
      home.persistence.${config._.persistent-home.dest} = {
        enable      = true;
        hideMounts  = true;    # hide the bind mounts from showing up as mounted drives in the file manager
        directories = config._.persistent-home.dirs;
        files       = config._.persistent-home.files;
      };
    };
  };
}
