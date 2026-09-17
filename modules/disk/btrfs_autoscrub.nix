{
  flake.aspects.disk.nixos = {
    services.btrfs.autoScrub = {
      enable   = true;
      interval = "monthly";

      # "/" already covers all the subvolumes
      # other paths are only useful for external devices
      fileSystems = [
        "/"                   
      ];
    };
  };
}
