{ inputs, lib, self, ... }:{
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

    nixos-images.nixos = {
      imports = [ inputs.nixos-images.nixosModules.image-installer ];
    };
  };

  # exposed as a package only, so nixos-hosts doesn't list the installer as a machine
  # build with: nix build .#iso-installer
  perSystem = { system, ... }: lib.optionalAttrs (lib.hasSuffix "-linux" system) {
    packages.iso-installer =(inputs.nixos-images.inputs.nixos-stable.lib.nixosSystem {
      modules = [
        self.modules.generic.options
        self.modules.nixos.nixos-images
        self.modules.nixos.location
        { nixpkgs.hostPlatform = system; }
      ];
    }).config.system.build.isoImage;
  };
}
