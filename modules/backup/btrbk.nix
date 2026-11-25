{
  flake.aspects.btrbk.nixos = { config, lib, ... }:
  let
    subvolumes = map (lib.removePrefix "/") config._.persistent-subvolumes;   # relative to the "/" volume
  in {
    services.btrbk = {
      # sshAccess = { # SSH keys that should be able to make or push snapshots on this system remotely
      #   key
      #   roles
      # }; 
      # onCalendar        = "daily";
      # niceness          = 10;               # niceness for local instances
      # ioSchedulingClass = "best-effort";    # best-effort, idle, realtime
      # instances = {
      #   "btrbk" = {                         # default instance name
      #     settings = {
      #       stream_compress       = "no";   # gzip, pigz, bzip2, pbzip2, bzip3, xz, lzo, lz4, zstd, no
      #       snapshot_preserve     = "14d";
      #       snapshot_preserve_min = "2d";
      #       volume = {
      #         "/mnt/btr_pool" = {
      #           subvolume = {
      #             home = {
      #               snapshot_create = "always";
      #             };
      #             rootfs = { };
      #           };
      #           target = "/mnt/btr_backup/mylaptop";
      #         };
      #       };
      #     };
      #     snapshotOnly = false;             # to skip backup creation and deletion steps
      #                                       # when you want to manually backup to an external drive
      #   };
      # };
      instances."persistent" = {              # service btrbk-persistent, /home is ephemeral and not worth a backup
        onCalendar   = null;                  # no timer, run with: systemctl start btrbk-persistent
        snapshotOnly = true;                  # no backup target yet
        settings = {
          backend               = "btrfs-progs";  # btrfs called directly, the sudo wrapper is wheel-only
          snapshot_preserve_min = "2d";
          snapshot_preserve     = "14d";
          volume."/" = {
            snapshot_dir = "mnt/snapshots/btrbk";   # relative to the volume, same btrfs filesystem as /nix
            subvolume    = lib.genAttrs subvolumes (name: {});   # system + one per user, snapshots named after the basename
          };
        };
      };
      extraPackages = [];
    };
    systemd.services.btrbk-persistent.serviceConfig = {   # root is required by the btrfs-progs backend
      User  = lib.mkForce "root";
      Group = lib.mkForce "root";
    };
    systemd.tmpfiles.rules = ["d /mnt/snapshots/btrbk 0755 root root -"];  # snapshot_dir must exist before the first run
  };
}
