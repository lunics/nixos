{ inputs, ... }:{
  flake-file.inputs.nixos-images = {
    url = "github:nix-community/nixos-images";
    inputs.nixos-unstable.follows = "nixpkgs";   # nixos-stable kept to match the official release
  };

  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.installer-ssh-keys = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
    };

    nixos-images.nixos = { config, ... }:{
      imports = [ inputs.nixos-images.nixosModules.image-installer ];

      users.users.root.openssh.authorizedKeys.keys = config._.installer-ssh-keys;
    };
  };
}
