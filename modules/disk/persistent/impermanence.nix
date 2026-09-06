{ inputs, ... }:{
  flake-file.inputs.impermanence.url  = "github:nix-community/impermanence";

  flake.aspects.persistent = {
    # the nixos module stays mandatory: it injects the home-manager one and owns the bind mounts
    nixos = { config, ... }:{
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      fileSystems."${config._.persistent-system.dest}".neededForBoot = true;
    };

    homeManager = { config, ... }:{
      home.persistence.${config._.persistent-home.dest} = {
        enable      = config._.persistent;
        hideMounts  = true;    # hide the bind mounts from showing up as mounted drives in the file manager
        directories = config._.persistent-home.dirs;
        files       = config._.persistent-home.files;
      };
    };
  };
}
