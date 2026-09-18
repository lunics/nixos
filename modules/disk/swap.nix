{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib; let
    _ = config._.swapfile-hibernation;
  in {
    zramSwap = {
      enable        = config._.zram-swap.enable;
      memoryPercent = config._.zram-swap.memoryPercent;
      priority      = config._.zram-swap.priority;
      algorithm     = "zstd";
    };

    swapDevices = [];   # the btrfs swapfiles are appended by disko

    # hibernation target, resume_offset is mandatory for a swapfile
    boot = mkIf (_.enable && _.resume_offset != null) {
      resumeDevice = "/dev/disk/by-label/NIXOS";
      kernelParams = [ "resume_offset=${toString _.resume_offset}" ];
    };

    # until the offset is measured, systemd would fall back on the paging swapfile
    systemd.sleep.extraConfig = mkIf (_.enable && _.resume_offset == null) "AllowHibernation=no";
  };
}
