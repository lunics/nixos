{ config, lib, ... }: with lib; {
  options._.disk = {
    device = mkOption {
      type    = types.str;
      default = "nvme0n1";
    };
    boot = mkOption {
      type    = types.str;
      default = "1G";
    };
    luks = mkOption {
      type    = types.bool;
      default = true;
    };
  };
}

