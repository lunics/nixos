{ config, lib, ... }: with lib; let 
  _ = config._.disk; 

  _mkIfElse = p: yes: no: mkMerge [ (mkIf p yes) (mkIf (!p) no) ];

  _subvolumes = {
    type       = "btrfs";
    extraArgs  = ["-L" "nixos" "-f"];
    subvolumes = lib.mkMerge [
    {
      "/root" = {
        mountpoint   = "/";
        mountOptions = ["subvol=root" "compress=zstd" "relatime"]; 
      };
      "/home" = {
        mountpoint   = "/home";
        mountOptions = ["subvol=home" "compress=zstd" "rw" "relatime" "nodev" "nosuid"]; 
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
        mountOptions = ["subvol=tmp" "compress=zstd" "rw" "nodev" "nosuid" "noexec"]; 
      };
      "/snapshots" = {
        mountpoint   = "/snapshots";
        mountOptions = ["subvol=snapshots" "compress=zstd"]; 
      };
    }
    (lib.mkIf config._.k3s {
      "/kube" = {
        mountpoint   = "/kube";
        mountOptions = ["subvol=persistent" "compress=zstd" "noatime"]; 
      };
    })];
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
