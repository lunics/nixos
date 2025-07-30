{
  services.restic = {
    server = {
      enable        = false;
      listenAddress = "8000";
      # package     = pkgs.restic-rest-server;
      appendOnly    = false;       # allows creation of new backups but prevents deletion and modification of existing backups
                                # useful when backing up systems that have a potential of being hacked
      dataDir       = "/var/lib/restic";
      extraFlags    = [];
      # htpasswd-file = "${dataDir}/.htpasswd";
      privateRepos  = false;   # enable private repos. Grants access only when a subdirectory with the same name as the user is specified in the repository URL
      prometheus    = false;     # enable Prometheus metrics at /metrics
    };

    backup = {
      "NAME1" = {
        backupCleanupCommand = "";        # script that must run after finishing the backup process
        backupPrepareCommand = "";        # script that must run before starting the backup process
        checkOpts = [];                   # options for 'restic check'
        createWrapper = true;
        # dynamicFilesFrom = "find /home/matt/git -type d -name .git";    #  script that produces a list of files to back up. Results are given to the '--files-from' option
        environmentFile = "";             # file containing the credentials to access the repository
        exclude = [                       # patterns to exclude when backing up
          # "/var/cache"
          # "/home/*/.cache"
          # ".git"
        ];
        extraBackupArgs = [
          # "--cleanup-cache"
          # "--exclude-file=/etc/nixos/restic-ignore"
        ];
        extraOptions = [];                # options to be passed to the restic --option
        inhibitsSleep = false;            # prevents the system from sleeping while backing up
        initialize = false;               # create the repository if it doesn't exist
        # package = pkgs.restic;
        # passwordFile = ""/etc/nixos/restic-password"";                # file repository password
        paths = [                         # paths to backup
        ];
        progressFps = 0.1;                # frequency of progress reporting
        pruneOpts = [                     # options to automatically prune old snapshots
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 75"
        ];
        rcloneConfig = {};
        rcloneConfigFile = "";
        rcloneOptions = {};               # options to pass to rclone to control
        # repository = "sftp:backup@192.168.1.100:/backups/‹name›";                  # repository to backup to
        repositoryFile = "";              # path to the file containing the repository location to backup to
        runCheck = false;                 # whether to run the check command. Set true only if checkOpts not empty
        timerConfig = {                   # backup scheduling
          OnCalendar = "daily";
          Persistent = true;
        }
        user = "root";
      };
    };
  };
}
