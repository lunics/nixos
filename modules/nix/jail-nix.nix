{
  flake-file.inputs.jail-nix.url = "sourcehut:~alexdavid/jail.nix";

  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._ = {
        allow-unfree-jailed = mkOption {
          type    = types.listOf types.package;
          default = [];
        };
      };
    };
  };
}
