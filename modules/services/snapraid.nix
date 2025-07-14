{
  services.snapraid = {
    enable = false;
    # dataDisks = {
    #   d1 = "/mnt/disk1/";
    #   d2 = "/mnt/disk2/";
    #   d3 = "/mnt/disk3/";
    # };
    # contentFiles = [
    #   "/var/snapraid.content"
    #   "/mnt/disk1/snapraid.content"
    #   "/mnt/disk2/snapraid.content"
    # ];
    # parityFiles = [
    #   "/mnt/diskp/snapraid.parity"
    #   "/mnt/diskq/snapraid.2-parity"
    #   "/mnt/diskr/snapraid.3-parity"
    #   "/mnt/disks/snapraid.4-parity"
    #   "/mnt/diskt/snapraid.5-parity"
    #   "/mnt/disku/snapraid.6-parity"
    # ];
    sync.interval = "daily";      # interval to run snapraid sync
    # extraConfig = ''
    #   nohidden
    #   blocksize 256
    #   hashsize 16
    #   autosave 500
    #   pool /pool
    # '';
    # exclude = [                   # exclude directives
    #   "*.unrecoverable"
    #   "/tmp/"
    #   "/lost+found/"
    # ];
    touchBeforeSync = true;       # snapraid touch is run before snapraid sync
    scrub = {
      interval  = "Mon *-*-* 02:00:00";   # interval to run snapraid scrub
      olderThan = 10;                     # number of days since data was last scrubbed before it can be scrubbed again
      plan      = 10;                     # percent of the array that should be checked by snapraid scrub
    };
  };
}
