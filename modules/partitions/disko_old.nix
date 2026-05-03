{ inputs, ... }:{
  flake.modules.nixos.disko = {

    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk = {
        main = {
          type    = "disk";
          device  = "/dev/nvme0n1";
          content = {
            type       = "gpt";
            partitions = {
              # efi system partition
              ESP = {
                size    = "512M";
                type    = "EF00";
                content = {
                  type         = "filesystem";
                  format       = "vfat";
                  mountpoint   = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };

              # btrfs root with subvolumes
              root = {
                size    = "100%";
                content = {
                  type       = "btrfs";
                  extraArgs  = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["subvol=root"]; 
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["subvol=home"]; 
                    };
                    # noatime avoids unnecessary writes on the nix store
                    "/nix" = {
                      mountpoint   = "/nix";
                      mountOptions = ["subvol=nix"]; 
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
