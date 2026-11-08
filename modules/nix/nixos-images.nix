{ inputs, lib, self, ... }:{
  flake-file.inputs.nixos-images = {
    url = "github:nix-community/nixos-images";
    inputs.nixos-unstable.follows = "nixpkgs";   # nixos-stable kept to match the official release
  };

  flake.aspects = {
    nixos-images.nixos = {
      imports = [
        inputs.nixos-images.nixosModules.image-installer
        self.modules.nixos.location
      ];

      boot.zfs.forceImportRoot = false;

      services.openssh.settings = {
        PermitRootLogin        = "yes";
        PasswordAuthentication = true;
      };

      services.tlp = {
        enable   = true;
        settings = {
          START_CHARGE_THRESH_BAT0 = 41;
          STOP_CHARGE_THRESH_BAT0  = 61;
          START_CHARGE_THRESH_BAT1 = 41;
          STOP_CHARGE_THRESH_BAT1  = 61;
        };
      };
    };
  };

  # build from the remote flake
  #   nix build github:lunics/nixos#iso-installer       can only use the raw hash
  #   nix build github:lunics/clan-hosts#iso-installer  can use both: raw hash and clan var installer-root-pwd
  # build from the local flake
  #   nix build .#iso-installer                         from a local clan flake (nixos or clan-hosts)
  perSystem = { system, ... }: lib.optionalAttrs (lib.hasSuffix "-linux" system) {
    # exposed as a package only, so nixos-hosts doesn't list the installer as a machine
    packages.iso-installer =(inputs.nixos-images.inputs.nixos-stable.lib.nixosSystem {
      modules = [
        self.modules.generic.options
        self.modules.nixos.nixos-images
        { nixpkgs.hostPlatform = system; }
      ];
    }).config.system.build.isoImage;
  };
}
