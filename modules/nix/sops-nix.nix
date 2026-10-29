{ inputs, ... }:{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.secrets = {
    nixos = { config, lib, ... }:{
      imports = [ inputs.sops-nix.nixosModules.sops ];

      users.groups.sops.name = config._.sops-group;

      _.persistent-system.dirs = [ 
        "/var/lib/sops-nix" 
      ];

      fileSystems."/home".neededForBoot = true;  # required for the boot when the age key is located in the user space
    };
    homeManager = { pkgs, ... }:{
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      _.persistent-home.dirs = [
        { directory = ".config/sops/age"; mode = "0700"; }    # age key of the sops cli
      ];

      home.packages = with pkgs; [
        sops
      ];
    };
  };
}
