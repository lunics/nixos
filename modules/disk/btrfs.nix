{ config, lib, ... }: with lib; let 
  _ = config._.disk; 

  _mkIfElse = p: yes: no: mkMerge [ (mkIf p yes) (mkIf (!p) no) ];

  _subvolumes = {
    type       = "btrfs";
    extraArgs  = ["-L" "nixos" "-f"];
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
    (mkIf _.btrfs_vol.impermanence {
      "/persistent" = {
        mountpoint   = "/persistent";
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
  config = _mkIfElse (_.luks or false)
  { # IF
    disko.devices.disk.${_.device}.content.partitions.luks.content.content = _subvolumes;
  }
  { # ELSE
    disko.devices.disk.${_.device}.content.partitions.btrfs = {
      size    = "100%";
      content = _subvolumes;
    };
  };
}
