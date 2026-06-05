{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib; let
    _ = config._.disk;

    _subvolumes = {
      type       = "btrfs";
      extraArgs  = ["--label" "NIXOS" "-f"];
      subvolumes = mkMerge [
        {
          "/root" = {
            mountpoint   = "/";
            mountOptions = ["subvol=root"] ++ _.btrfs_opts;
          };
          "/nix" = {
            mountpoint   = "/nix";
            mountOptions = ["subvol=nix"] ++ _.btrfs_opts;
          };
          "/home" = {
            mountpoint   = "/home";
            mountOptions = ["subvol=home" "rw" "nodev" "nosuid"] ++ _.btrfs_opts;
          };
          "/log" = {
            mountpoint   = "/var/log";
            mountOptions = ["subvol=log" "rw" "nodev" "nosuid" "noexec"] ++ _.btrfs_opts;
          };
          "/tmp" = {
            mountpoint   = "/tmp";
            mountOptions = ["subvol=tmp" "rw" "nodev" "nosuid" "noexec"] ++ _.btrfs_opts;
          };
          "/snapshots" = {
            mountpoint   = "/snapshots";
            mountOptions = ["subvol=snapshots"] ++ _.btrfs_opts;
          };
        }
        (mkIf _.btrfs_vol.persistent {
          "/persistent" = {
            mountpoint   = config._.persistent.dest;
            mountOptions = ["subvol=persistent"] ++ _.btrfs_opts;
          };
        })
        (mkIf _.btrfs_vol.kube {
          "/kube" = {
            mountpoint   = "/kube";
            mountOptions = ["subvol=kube"] ++ _.btrfs_opts;
          };
        })
      ];
    };
  in {
    config = mkMerge [
      (mkIf _.luks {
        disko.devices.disk.${_.device}.content.partitions.luks.content.content = _subvolumes;
      })
      (mkIf (! _.luks) {
        disko.devices.disk.${_.device}.content.partitions.btrfs = {
          size    = "100%";
          content = _subvolumes;
        };
      })
    ];
  };
}
