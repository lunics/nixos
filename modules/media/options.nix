{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      instaloader-login = mkOption {
        type    = types.nullOr types.path;
        default = null;
      };

      spotify = {
        username = mkOption {
          type    = types.nullOr types.str;
          default = null;
        };
        token = mkOption {
          type    = types.nullOr types.str;
          default = null;
        };
      };
    };
  };
}
