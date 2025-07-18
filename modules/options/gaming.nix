{ config, lib, ... }:{
  options = {
    _gaming = lib.mkEnableOption "";

    _steam = lib.mkOption {
      type    = lib.types.bool;
      default = config._gaming;
    };

    _gamemode = lib.mkOption {
      type    = lib.types.bool;
      default = config._gaming;
    };

    _gamescope = lib.mkOption {
      type    = lib.types.bool;
      default = config._gaming;
    };
  };
}
