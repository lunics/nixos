{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      nix.trusted-users = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
      flake_dir = mkOption {
        type = types.strMatching ".+";    # mandatory, an empty value is refused
      };
      allow-unfree = mkOption {
        type    = types.listOf types.package;
        default = [];
      };
      state-version = mkOption {
        type    = types.str;
        default = "26.11";
      };
      machine-index = mkOption {
        type    = types.int;
        default = "";
      };
    };
  };
}
