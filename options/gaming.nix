{ config, lib, ... }: with lib; {
  options._ = {
    gaming = mkEnableOption "";

    steam = mkOption {
      type    = types.bool;
      default = config._.gaming;
    };

    gamemode = mkOption {
      type    = types.bool;
      default = config._.gaming;
    };

    gamescope = mkOption {
      type    = types.bool;
      default = config._.gaming;
    };
  };
}
