{
  flake.aspects.boot.nixos = {
    boot.tmp = {
      cleanOnBoot = false;              # delete all files in /tmp during boot
      useTmpfs    = false;              # mount a tmpfs on /tmp during boot
      tmpfsSize   = "50%";
      useZram     = false;              # mount a zram device on /tmp during boot
      zramSettings = {
        zram-size = "ram * 0.5";
        fs-type   = "ext4";
        options   = "X-mount.mode=1777,discard";
        compression-algorithm = "zstd";
      };
      tmpfsHugeMemoryPages = "never";   # never, always, within_size, advise
    };
  };
}
