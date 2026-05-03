{ config, lib, ... }: with lib; let
  _     = config._.disk; 
  _luks = "/dev/mapper/luks";
in {
  config = mkMerge [
  {
    fileSystems = {
      "/nix".neededForBoot        = true;
      "/var/log".neededForBoot    = true;
    };
  }
  (mkIf config._.impermanence {
    fileSystems."/persistent".neededForBoot = true;
  })
  # (mkIf _.dual_boot {
  #   fileSystems = {
  #     "/boot" = { 
  #       device = "/dev/disk/by-uuid/${_.boot_uuid}";
  #       fsType = "vfat";
  #     };
  #     # "/root" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=root"];
  #     # };
  #     # "/nix" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=nix"];
  #     # };
  #     # "/home" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=home" "rw" "nodev" "nosuid"];
  #     # };
  #     # "/var/log" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=log" "rw" "nodev" "nosuid" "noexec"];
  #     # };
  #     # "/tmp" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=tmp" "rw" "nodev" "nosuid" "noexec"];
  #     # };
  #     # "/snapshots" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=snapshots"];
  #     # };
  #     # "/kube" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=kube"];
  #     # };
  #     # "/persistent" = { 
  #     #   device  = _luks;
  #     #   fsType  = "btrfs";
  #     #   options = [_.btrfs_opts "subvol=persistent"];
  #     # };
  #   };
  # })
  ];
}
