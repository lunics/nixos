{
  flake.aspects.options.generic = { config, lib, ... }: with lib; {
    options._ = {
      steam = mkOption {
        type    = types.bool;
        default = true;
      };

      gamemode = mkOption {
        type    = types.bool;
        default = true;
      };

      gamescope = mkOption {
        type    = types.bool;
        default = true;
      };
    };
  };
}
