{ inputs, ... }:{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects = { aspects, ... }:{
    lanzaboot = {
      includes = with aspects; [
        fwupd
      ];
      nixos = { config, lib, pkgs, ... }: {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

        config = {
          assertions = [{
            assertion = config._.disk.boot-mode == "uefi";
            message   = "the lanzaboot aspect requires _.disk.boot-mode = \"uefi\"";
          }];

          environment.systemPackages = [
            pkgs.sbctl    # for debugging and troubleshooting secure boot
          ];

          boot.loader.systemd-boot.enable = lib.mkForce false;

          boot.lanzaboote = {
            enable    = true;                     # replaces systemd-boot
            pkiBundle = "/var/lib/secure-boot";   # where are store the key from sbctl
            autoGenerateKeys.enable = true;
              # to avoid manual sudo sbctl create-keys
              # Keys are generated in a systemd service
              # so you will need to actually boot the system to generate the keys, not by running nixos-rebuild switch
            autoEnrollKeys = {
              enable                     = true;  # to avoid manual sudo sbctl enroll-keys --microsoft
              autoReboot                 = true;  # because it relies on systemd-boot to apply enrollment
              allowBrickingMyMachine     = true;  # potential to soft brick, but to not enroll Microsoft keys
              includeMicrosoftKeys       = false;
              includeChecksumsFromTPM    = false; # experimental
              includeFirmwareBuiltinKeys = false; # Some machines like Frameworks, the firmware requires OEM certificates
                                                  # (pre-provisioned keys) to be retained so that features like
                                                  # vendor-provided firmware updates continue to function.
            };

            configurationLimit = 4;     # systemd-pcrlock predicts at most 8 variants per pcr (2 loaders x 4 generations)

            measuredBoot = {
              enable                     = true;                              # needs a TPM 2.0, check with systemd-pcrlock is-supported
              pcrs                       = [ 0 4 7 ];                         # firmware code, uki, secure boot state; 1, 2, 3 may be flaky
              pcrlockDirectory           = "/var/lib/pcrlock.d";
              pcrlockPolicy              = "/var/lib/systemd/pcrlock.json";
              staticMeasurements         = {};
              autoCryptenroll = {
                enable     = false;                                           # re-enrolls an existing tpm2 slot only, fails on a fido2-only volume
                device     = "/dev/disk/by-partlabel/LUKS";
                autoReboot = false;
              };
            };
          };

          _.persistent-system.dirs = [
            "/var/lib/secure-boot"
          ] ++ lib.optional config.boot.lanzaboote.measuredBoot.autoCryptenroll.enable
            "/var/lib/auto-cryptenroll";    # marker file, re-enrolls the tpm at every boot otherwise
        };
      };
    };
  };
}
