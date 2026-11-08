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

    nixos-images.nixos = { lib, ... }:
    let
      # public clan var of nixos-hosts, absent when built from this repo
      clan-pwd-hash = self + "/vars/shared/installer-root-pwd/password-hash/value";
    in {
      imports = [
        inputs.nixos-images.nixosModules.image-installer
        self.modules.nixos.location
      ];

      boot.zfs.forceImportRoot = false;

      users.users.root = {
        hashedPassword = if builtins.pathExists clan-pwd-hash
                         then lib.fileContents clan-pwd-hash
                         else "$y$j9T$V3OR0uHvpa3VEUnuYcMDM.$ZcMsQr5izbIqOeYTtDTiRFtzVJWTI4DkDw6gms8xPnC";  # rescue password
        initialHashedPassword = lib.mkForce null;   # empty one from installation-device, avoids the multiple passwords warning
      };
      system.activationScripts.root-password = lib.mkForce "";   # drop the random xkcdpass password set at each boot

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
