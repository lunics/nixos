{
  services.snapper = {
    configs = {                 # Subvolume configuration
      # home = {
      #   SUBVOLUME               = "/home";          # subvolume or mount point, has to contain a subvolume named .snapshots
      #   FSTYPE                  = "btrfs";          # btrfs, bcachefs
      #   ALLOW_USERS             = [ "alice" ];          # users allowed to operate with the config
      #   ALLOW_GROUPS            = [];                   # groups //
      #   TIMELINE_CREATE         = true;             # hourly snapshots created
      #   TIMELINE_CLEANUP        = true;            # timeline cleanup algorithm should be run for the config
      #   TIMELINE_LIMIT_DAILY    = 10;         # Limits for timeline cleanup.
      #   TIMELINE_LIMIT_HOURLY   = 10;
      #   TIMELINE_LIMIT_MONTHLY  = 10;
      #   TIMELINE_LIMIT_QUARTERL = 0;
      #   TIMELINE_LIMIT_WEEKLY   = 0;
      #   TIMELINE_LIMIT_YEARLY   = 10;
      # };
    };
    snapshotInterval   = "hourly";
    cleanupInterval    = "1d";
    filters            = "";            # global display difference filter
    persistentTimer    = false;
    snapshotRootOnBoot = false;
  };
}
