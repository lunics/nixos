{
  flake.aspects.options.generic = { config, lib, ... }: with lib; let
    # installed RAM in MiB, smbios reports each module size in KiB
    _ram = foldl' add 0 (filter isInt (map (_dev: _dev.size or 0)
      (config.hardware.facter.report.smbios.memory_device or []))) / 1024;
  in {
    options._ = {
      swap-dir = mkOption {
        type    = types.str;
        default = "/var/lib/swap";    # btrfs subvolume holding the swapfiles
      };

      zram-swap = {
        enable = mkEnableOption "";

        memoryPercent = mkOption {
          type    = types.int;
          default = 50;               # 50% of ZRAM
        };

        priority = mkOption {
          type    = types.int;
          default = 5;
        };
      };

      swapfile-zram = {
        enable = mkEnableOption "";   # paging swapfile, takes over once zram is full

        size = mkOption {
          type    = types.int;
          default = 8192;             # MiB, overflow buffer, not meant to hold an hibernation image
        };
      };

      swapfile-hibernation = {
        enable = mkEnableOption "";   # second swapfile, kept free to hold the hibernation image

        size = mkOption {
          type    = types.int;
          default = if _ram > 0 then _ram else 8192;  # MiB, the image holds the whole RAM
        };

        resume_offset = mkOption {
          type    = types.nullOr types.int;
          default = null;             # btrfs inspect-internal map-swapfile -r <swap-dir>/hibernate
        };
      };
    };
  };
}
