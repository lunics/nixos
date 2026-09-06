{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      impermanence = mkEnableOption "";
      preservation = mkEnableOption "";

      persistent = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";
        };
        dirs = mkOption {
          type    = types.listOf types.str;    # str: home paths are relative to $HOME
          default = [];   # don't add paths here, they will be overwritten
        };
        files = mkOption {
          type    = types.listOf types.str;    # str: home paths are relative to $HOME
          default = [];
        };
      };
    };
  };
}
