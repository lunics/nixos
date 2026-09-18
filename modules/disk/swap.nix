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

    boot = mkIf _.enable {
      # hibernation target, resume_offset is mandatory for a swapfile
      resumeDevice = "/dev/disk/by-label/NIXOS";
      kernelParams = optional (_.resume_offset != null) "resume_offset=${toString _.resume_offset}";
    };
  };
}
