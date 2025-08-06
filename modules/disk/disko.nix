{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type    = "disk";
        device  = "/dev/nvme0n1";
        content = {
          type       = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name  = "ESP";
              size  = "512M";
              type  = "EF00";
              content = {
                type         = "filesystem";
                format       = "vfat";
                mountpoint   = "/boot";
                mountOptions = [ "defaults" ]; }; };
            luks = {
              size    = "100%";
              label   = "luks";
              content = {
                type          = "luks";
                name          = "luks";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue" ];
                # https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
                # settings = {    # KO BREAKS LUKS on nixos-anywhere
                #   crypttabExtraOpts = [ "fido2-device=auto" "token-timeout=10" ]; };
                content = {
                  type       = "btrfs";
                  extraArgs  = ["-L" "nixos" "-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["subvol=root" "compress=zstd" "relatime"]; };

                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["subvol=home" "compress=zstd" "rw" "relatime" "nodev" "nosuid"]; };

                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["subvol=nix" "compress=zstd" "noatime"]; };

                    "/persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = ["subvol=persistent" "compress=zstd" "noatime"]; };

                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = ["subvol=log" "compress=zstd" "rw" "relatime" "nodev" "nosuid" "noexec"]; };

                    "/tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = ["subvol=log" "compress=zstd" "rw" "nodev" "nosuid" "noexec"]; };

                    "/snapshots" = {
                      mountpoint = "/snapshots";
                      mountOptions = ["subvol=log" "compress=zstd"]; };
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
