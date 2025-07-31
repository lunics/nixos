{ config, lib, ... }:{
  options._ = {
    gaming = lib.mkEnableOption "";

    steam = lib.mkOption {
      type    = lib.types.bool;
      default = config._.gaming;
    };

    gamemode = lib.mkOption {
      type    = lib.types.bool;
      default = config._.gaming;
    };

    gamescope = lib.mkOption {
      type    = lib.types.bool;
      default = config._.gaming;
    };
  };
}
