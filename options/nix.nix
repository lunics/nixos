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

      allow-unfree-jailed = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
    };
  };
}
