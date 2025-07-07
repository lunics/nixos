{
  # replaced by manual sync profile
  services.psd = {
    enable      = true;
    browsers    = [ 
      # "zen-twilight"
      "firefox"
      # "google-chrome"
    ];
    resyncTimer = "1h";     # time to wait before syncing browser profiles back to the disk
    useBackup   = true;     # enable the crash recovery feature
    backupLimit = 5;
  };
}
