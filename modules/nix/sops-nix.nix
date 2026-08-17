{ inputs, ... }:{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.secrets = {
    nixos = { config, lib, ... }:{
      imports = [ inputs.sops-nix.nixosModules.sops ];

      users.groups.sops.name = config._.sops-group;

      _.persistent.dirs = lib.mkIf config._.impermanence [ 
        "/var/lib/sops-nix" 
      ];

      fileSystems."/home".neededForBoot = true;  # required for the boot when the age key is located in the user space
    };
    homeManager = { pkgs, ... }:{
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = with pkgs; [
        sops
      ];
    };
  };
}
