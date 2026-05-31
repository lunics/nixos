{
  flake-file.inputs.jail-nix.url = "sourcehut:~alexdavid/jail.nix";

  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._ = {
        allow-unfree-jailed = mkOption {
          type = types.listOf (types.submodule {
            options = {
              name = mkOption { type = types.str; };
              pkg  = mkOption { type = types.package; };
            };
          });
          default = [];
        };
      };
    };

    nix.homeManager = { config, ... }: {
      home.packages = map (e: e.pkg) config._.allow-unfree-jailed;
    };
  };
}
