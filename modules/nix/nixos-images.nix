{ inputs, lib, self, config, ... }:
let
  iso-installer = config.iso-installer;
in {
  config.flake-file.inputs.nixos-images = {
    url = "github:nix-community/nixos-images";
    inputs.nixos-unstable.follows = "nixpkgs";   # nixos-stable kept to match the official release
  };

  # Root keys of the iso, set by the consuming flake (e.g. nixos-hosts from its clan vars).
  # Named so a clan app (e.g. install-machine) reads lib.attrNames config.iso-installer.ssh-keys
  # at eval time to know which private keys to load.
  options.iso-installer.ssh-keys = lib.mkOption {
    type    = lib.types.attrsOf lib.types.str;
    default = {};
  };

  config.flake.aspects = {
    nixos-images.nixos = {
      imports = [
        inputs.nixos-images.nixosModules.image-installer
        self.modules.nixos.location
      ];

      boot.zfs.forceImportRoot = false;

      users.users.root.openssh.authorizedKeys.keys =
        lib.filter (key: key != "") (lib.attrValues iso-installer.ssh-keys);

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
  #   from nixos-hosts: nix run .#build-iso-installer   iso-installer.ssh-keys + random password shown on the console
  #   from nixos:       nix build .#iso-installer       random password shown on the console only
  #                     nix build .#iso-installer -o ~/.cache/iso-installer/result   out link in the user cache instead of ./result
  config.perSystem ={ system, ... }: lib.optionalAttrs (lib.hasSuffix "-linux" system) {
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
