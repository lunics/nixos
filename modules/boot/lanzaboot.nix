{ inputs, ... }:{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.lanzaboot.nixos = { config, lib, pkgs, ... }: {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    config = {
      environment.systemPackages = [
        pkgs.sbctl    # for debugging and troubleshooting secure boot
      ];

      boot.loader.systemd-boot.enable = lib.mkForce false;

      boot.lanzaboote = {
        enable    = true;                     # replaces systemd-boot
        pkiBundle = "/var/lib/secure_boot";   # where are store the key from sbctl
        autoGenerateKeys.enable = true;
          # to avoid manual sudo sbctl create-keys
          # Keys are generated in a systemd service
          # so you will need to actually boot the system to generate the keys, not by running nixos-rebuild switch
        autoEnrollKeys = {
          enable                  = true;     # to avoid manual sudo sbctl enroll-keys --microsoft
          autoReboot              = true;     # because it relies on systemd-boot to apply enrollment
          allowBrickingMyMachine  = true;
          includeMicrosoftKeys    = false;
          includeChecksumsFromTPM = false;    # experimental
        };
      };

      _.persistent-system.dirs = [
        "/var/lib/secure_boot"
      ];
    };
  };
}
