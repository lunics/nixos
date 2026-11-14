{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      user = mkOption {
        type    = types.str;
        default = "user-nix";
      };

      user_id = mkOption {
        type    = types.int;
        default = 1000;
      };
    };
  };
}
