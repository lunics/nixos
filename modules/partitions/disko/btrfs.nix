{
  flake.modules.nixos.disko = { lib, ... }: with lib; {
    disko.devices.disk.nvme0n1.content.partitions = {
      size    = "100%";
      content = {
        type       = "btrfs";
        extraArgs  = ["-L" "nixos" "-f"];
        subvolumes = {
          "/root" = {
            mountpoint   = "/";
            mountOptions = ["subvol=root"]; 
          };
          "/nix" = {
            mountpoint   = "/nix";
            mountOptions = ["subvol=nix"]; 
          };
          "/home" = {
            mountpoint   = "/home";
            mountOptions = ["subvol=home" "rw" "nodev" "nosuid"]; 
          };
          "/log" = {
            mountpoint   = "/var/log";
            mountOptions = ["subvol=log" "rw" "nodev" "nosuid" "noexec"];
          };
          "/tmp" = {
            mountpoint   = "/tmp";
            mountOptions = ["subvol=tmp" "rw" "nodev" "nosuid" "noexec"];
          };
          "/snapshots" = {
            mountpoint   = "/snapshots";
            mountOptions = ["subvol=snapshots"];
          };
        };
      };
    };
  };
}
