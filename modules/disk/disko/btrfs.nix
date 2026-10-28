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
            mountOptions = _.btrfs_opts;
          };
          "/nix" = {
            mountpoint   = "/nix";
            mountOptions = _.btrfs_opts;
          };
          "/home" = {
            mountpoint   = "/home";
            mountOptions = ["rw" "nodev" "nosuid"] ++ _.btrfs_opts;
          };
          "/log" = {
            mountpoint   = "/var/log";
            mountOptions = ["rw" "nodev" "nosuid" "noexec"] ++ _.btrfs_opts;
          };
          "/tmp" = {
            mountpoint   = "/tmp";
            mountOptions = ["rw" "nodev" "nosuid" "noexec"] ++ _.btrfs_opts;
          };
          "/snapshots" = {    # every snapshot and the rollback archives, mounted on first access only
            mountpoint   = "/mnt/snapshots";
            mountOptions = ["nodev" "nosuid" "noexec" "noauto" "x-systemd.automount" "x-systemd.idle-timeout=10min"] ++ _.btrfs_opts;
          };
        }
        _.subvolumes
      ];
    };
  in {
    config = mkMerge [
      (mkIf _.luks {
        disko.devices.disk.main.content.partitions.luks.content.content = _subvolumes;
      })
      (mkIf (! _.luks) {
        disko.devices.disk.main.content.partitions.btrfs = {
          size    = "100%";
          label   = "NIXOS";
          type    = mkIf config._.raspberry-pi "8305";   # linux arm64 root
          uuid    = _.btrfs-partuuid;
          content = _subvolumes;
        };
      })
    ];
  };
}
