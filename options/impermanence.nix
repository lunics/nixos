{ lib, ... }: with lib; {
  options._ = {
    impermanence = mkEnableOption "";

    persistent = {
      dirs = mkOption {
        type    = types.listOf types.path;
        default = [];
      };
      files = mkOption {
        type    = types.listOf types.path;
        default = [];
      };
    };
  };
}
