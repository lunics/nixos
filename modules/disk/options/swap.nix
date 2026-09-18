{
  flake.aspects.options.generic = { config, lib, ... }: with lib; let
    # installed RAM in GiB, smbios reports each module size in KiB
    _ram = foldl' add 0 (filter isInt (map (_dev: _dev.size or 0)
      (config.hardware.facter.report.smbios.memory_device or []))) / 1048576;
  in {
    options._ = {
      zram-swap = {
        enable = mkEnableOption "";

        memoryPercent = mkOption {
          type    = types.int;
          default = 50;  # 50% of ZRAM
        };

        priority = mkOption {
          type    = types.int;
          default = 5;
        };
      };

      swapfile-zram = {
        enable = mkEnableOption "";   # paging swapfile, takes over once zram is full

        size = mkOption {
          type    = types.str;
          default = "8G";   # overflow buffer, not meant to hold an hibernation image
        };
      };

      swapfile-hibernation = {
        enable = mkEnableOption "";   # second swapfile, kept free to hold the hibernation image

        size = mkOption {
          type    = types.str;
          default = if _ram > 0 then "${toString _ram}G" else "8G";  # the image holds the whole RAM
        };

        resume_offset = mkOption {
          type    = types.nullOr types.int;
          # btrfs inspect-internal map-swapfile -r /var/lib/swap/hibernate
          default = null;
        };
      };
    };
  };
}
