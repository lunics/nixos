{ inputs, lib, self, ... }:{
  flake-file.inputs.nixos-images = {
    url = "github:nix-community/nixos-images";
    inputs.nixos-unstable.follows = "nixpkgs";   # nixos-stable kept to match the official release
  };

  flake.aspects = {
    nixos-images.nixos =
    let
      # public clan var of nixos-hosts, absent when built from this repo
      ssh-pub-key = self + "/vars/shared/iso-installer-ssh-key/id_ed25519.pub/value";
    in {
      imports = [
        inputs.nixos-images.nixosModules.image-installer
        self.modules.nixos.location
      ];

      boot.zfs.forceImportRoot = false;

      users.users.root.openssh.authorizedKeys.keys = 
        lib.optional (builtins.pathExists ssh-pub-key) (lib.fileContents ssh-pub-key);

      services.openssh.settings = {
        PermitRootLogin        = "yes";
        PasswordAuthentication = true;
        PubkeyAuthentication   = true;
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

  # root ssh access to the iso
  #   from nixos-hosts: nix run .#build-iso-installer   iso-installer-ssh-key clan var + random password shown on the console
  #   from nixos:       nix build .#iso-installer       random password shown on the console only
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
