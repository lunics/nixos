{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib; let
    _ = config._.swap;
  in {
    zramSwap = {
      enable        = config._.zramSwap.enable;
      memoryPercent = config._.zramSwap.memoryPercent;
      priority      = config._.zramSwap.priority;
      algorithm     = "zstd";
    };

    swapDevices = [];   # the btrfs swapfile is appended by disko

    boot = mkIf _.enable {
      # hibernation target, resume_offset is mandatory for a swapfile
      resumeDevice = "/dev/disk/by-label/NIXOS";
      kernelParams = optional (_.resume_offset != null) "resume_offset=${toString _.resume_offset}";
    };
  };
}
