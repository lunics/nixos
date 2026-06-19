{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      nix.trusted-users = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
      flake_dir = mkOption {
        type    = types.str;
        default = "";
      };
      allow-unfree = mkOption {
        type    = types.listOf types.package;
        default = [];
      };
      state-version = mkOption {
        type    = types.str;
        default = "26.05";
      };
    };
  };
}
