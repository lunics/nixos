{
  flake.modules.generic.myoptions = { lib, ... }: with lib; {
    options._ = {
      impermanence = mkEnableOption "";

      persistent = {
        dirs = mkOption {
          type    = types.listOf types.path;
          default = [];   # don't add paths here, they will be overwritten
        };
        files = mkOption {
          type    = types.listOf types.path;
          default = [];
        };
      };
    };
  };
}
