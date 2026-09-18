{
  flake.aspects.disk.nixos = { config, lib, pkgs, ... }: with lib;
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

    # the offset only exists once the file does, so it is checked here instead of at eval
    system.activationScripts.swapfile-hibernation = mkIf _hiber.enable ''
      if [ -e "${_dir}/hibernate" ]; then
        _offset=$(${pkgs.btrfs-progs}/bin/btrfs inspect-internal map-swapfile -r "${_dir}/hibernate" 2>/dev/null || true)
        ${if _hiber.resume_offset == null
          then ''
            if [ -n "$_offset" ]; then
              echo "swapfile-hibernation: hibernation is off, set resume_offset = $_offset"
            fi
          ''
          else ''
            if [ -n "$_offset" ] && [ "$_offset" != "${toString _hiber.resume_offset}" ]; then
              echo "swapfile-hibernation: resume_offset is ${toString _hiber.resume_offset} but the file starts at $_offset"
            fi
          ''}
      fi
    '';
  };
}
