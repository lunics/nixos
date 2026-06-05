{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      impermanence = mkEnableOption "";
      preservation = mkEnableOption "";

      persistent = {
        dest = mkOption {
          type    = types.str;
          default = "/persistent";
        };
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
