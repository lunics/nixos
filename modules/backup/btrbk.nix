{
  flake.aspects.btrbk.nixos = {
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
      instances."home" = {                    # service btrbk-home
        onCalendar   = null;                  # no timer, run with: systemctl start btrbk-home
        snapshotOnly = true;                  # no backup target yet
        settings = {
          snapshot_preserve_min = "2d";
          snapshot_preserve     = "14d";
          volume."/" = {
            snapshot_dir = "mnt/snapshots/btrbk";   # relative to the volume, same btrfs filesystem as /home
            subvolume    = "home";
          };
        };
      };
      extraPackages = [];
    };
    systemd.tmpfiles.rules = ["d /mnt/snapshots/btrbk 0755 root root -"];  # snapshot_dir must exist before the first run
  };
}
