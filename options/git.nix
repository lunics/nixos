{
  flake.aspects.options.nixos = { config, lib, ... }: with lib; {
    options._.git = {
      user = mkOption {
        type    = types.str;
        default = config._.user;
      };
      email = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
