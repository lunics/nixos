{ config, lib, ... }: with lib; let 
  _ = config._.disk; 

  _mkIfElse = p: yes: no: mkMerge [ (mkIf p yes) (mkIf (!p) no) ];

  _subvolumes = {
    type       = "btrfs";
    extraArgs  = ["-L" "nixos" "-f"];
    subvolumes = {
      "/root" = {
        mountpoint   = "/";
        mountOptions = ["subvol=root" "compress=zstd" "relatime"]; 
      };
      "/etc" = {
        mountpoint   = "/etc";
        mountOptions = ["subvol=etc" "compress=zstd" "noatime" "nodev" "nosuid" "noexec"]; 
      };
      # "/run" = {
      #   mountpoint   = "/run";
      #   mountOptions = ["subvol=run" "compress=zstd" "noatime"];
      # };
      "/home" = {
        mountpoint   = "/home";
        mountOptions = ["subvol=home" "compress=zstd" "rw" "relatime" "nodev" "nosuid"]; ## noatime over relatime ?
      };
      "/nix" = {
        mountpoint   = "/nix";
        mountOptions = ["subvol=nix" "compress=zstd" "noatime"]; 
      };
      "/persistent" = {
        mountpoint   = "/persistent";
        mountOptions = ["subvol=persistent" "compress=zstd" "noatime"]; 
      };
      "/log" = {
        mountpoint   = "/var/log";
        mountOptions = ["subvol=log" "compress=zstd" "rw" "relatime" "nodev" "nosuid" "noexec"]; 
      };
      "/tmp" = {
        mountpoint   = "/tmp";
        mountOptions = ["subvol=tmp" "compress=zstd" "rw" "noatime" "nodev" "nosuid" "noexec"];
      };
      "/snapshots" = {
        mountpoint   = "/snapshots";
        mountOptions = ["subvol=snapshots" "compress=zstd" "rw" "noatime" "nodev" "nosuid" "noexec"]; 
      };
      "/trash" = {
        mountpoint   = "/trash";
        mountOptions = ["subvol=trash" "compress=zstd" "r" "noatime" "nodev" "nosuid" "noexec"];
      };
      # "/k3s" = {
      #   mountpoint   = "/k3s";
      #   mountOptions = ["subvol=k3s" "compress=zstd" "rw" "noatime"]; 
      # };
      # "/virt/qemu" = {
      #   mountpoint   = "/virt/qemu";
      #   mountOptions = ["subvol=qemu" "compress=zstd" "rw" "noatime"]; 
      # };
      # "/virt/xen" = {
      #   mountpoint   = "/virt/xen";
      #   mountOptions = ["subvol=xen" "compress=zstd" "rw" "noatime"]; 
      # };
    };
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
