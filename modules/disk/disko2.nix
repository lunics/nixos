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

                settings = {    
                  # https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
                  # KO BREAKS LUKS on nixos-anywhere ??
                  crypttabExtraOpts = [ 
                    "fido2-device=auto" 
                    "token-timeout=10" 
                  ];

                  # keyFile = "/tmp/secret.key";          # disable passwordFile if you want to use keyFile
                  # passwordFile = "/tmp/secret.key";     # disable settings.keyFile if you want to use interactive password entry
                  # allowDiscards = true;       # improves performance on SSD storage but has security implications
                };
                additionalKeyFiles = [ "/tmp/additionalSecret.key" ];

                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "nixos" "-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint   = "/";
                      mountOptions = ["subvol=root" "compress=zstd" "relatime" ]; };

                    "/etc" = {
                      mountpoint   = "/etc";
                      mountOptions = ["subvol=etc" "compress=zstd" "noatime" "nodev" "nosuid" "noexec" ]; };

                    # "/run" = {
                    #   mountpoint   = "/run";
                    #   mountOptions = ["subvol=etc" "compress=zstd" "noatime"]; };

                    "/home" = {
                      mountpoint   = "/home";
                      mountOptions = ["subvol=home" "compress=zstd" "rw" "noatime" "nodev" "nosuid" ]; };

                    "/nix" = {
                      mountpoint   = "/nix";
                      mountOptions = ["subvol=nix" "compress=zstd" "noatime"]; };

                    "/log" = {
                      mountpoint   = "/var/log";
                      mountOptions = ["subvol=log" "compress=zstd" "rw" "relatime" "nodev" "nosuid" "noexec" ]; };

                    "/tmp" = {
                      mountpoint   = "/tmp";
                      mountOptions = ["subvol=tmp" "compress=zstd" "rw" "noatime" "nodev" "nosuid" "noexec" ]; };

                    "/trash" = {
                      mountpoint   = "/trash";
                      mountOptions = ["subvol=trash" "compress=zstd" "r" "noatime" "nodev" "nosuid" "noexec" ]; };

                    "/snapshots" = {
                      mountpoint   = "/snapshots";
                      mountOptions = ["subvol=snapshots" "compress=zstd" "rw" "noatime" "nodev" "nosuid" "noexec" ]; };

                    "/k3s" = {
                      mountpoint   = "/k3s";
                      mountOptions = ["subvol=k3s" "compress=zstd" "rw" "noatime" ]; };

                    "/virt/qemu" = {
                      mountpoint   = "/virt/qemu";
                      mountOptions = ["subvol=qemu" "compress=zstd" "rw" "noatime" ]; };

                    "/virt/xen" = {
                      mountpoint   = "/virt/xen";
                      mountOptions = ["subvol=xen" "compress=zstd" "rw" "noatime" ]; };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  # fileSystems."/var/log".neededForBoot = true;
}
