{
  services.btrfs.autoScrub = {
    enable      = true;
    interval    = "monthly";  # systemd calendar timer
    fileSystems = [           # paths to btrfs filesystems
      "/"                     # / already covers all the subvolumes, other paths are only useful for external devices
    ];
  };
}
