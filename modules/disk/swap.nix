{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib;
  let
    _zram  = config._.swapfile-zram;
    _hiber = config._.swapfile-hibernation;
    _prio  = config._.zram-swap.priority;
    _dir   = config._.swap-dir;
  in {
    zramSwap = {
      enable        = config._.zram-swap.enable;
      memoryPercent = config._.zram-swap.memoryPercent;
      priority      = _prio;
      algorithm     = "zstd";
    };

    # created by btrfs mkswapfile, after the subvolume is mounted
    swapDevices = optional _zram.enable  { 
      device   = "${_dir}/swapfile";  
      size     = _zram.size;  
      priority = _prio - 2; }
    ++ optional _hiber.enable { 
      device   = "${_dir}/hibernate"; 
      size     = _hiber.size; 
      priority = _prio - 4; 
    };

    # hibernation target, resume_offset is mandatory for a swapfile
    boot = mkIf (_hiber.enable && _hiber.resume_offset != null) {
      resumeDevice = "/dev/disk/by-label/NIXOS";
      kernelParams = [ "resume_offset=${toString _hiber.resume_offset}" ];
    };

    # until the offset is measured, systemd would fall back on the paging swapfile
    systemd.sleep.extraConfig = mkIf (_hiber.enable && _hiber.resume_offset == null) "AllowHibernation=no";
  };
}
