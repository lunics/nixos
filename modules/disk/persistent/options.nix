{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      persistent = mkEnableOption "";   # nixos: preservation, home-manager: impermanence

      persistent-system = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";
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

      persistent-home = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";   # impermanence appends /home/<user> itself
        };
        dirs = mkOption {
          type    = types.listOf types.str;    # str: paths are relative to $HOME
          default = [];
        };
        files = mkOption {
          type    = types.listOf types.str;
          default = [];
        };
      };
    };
  };
}
