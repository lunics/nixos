{
  flake-file.inputs.jail-nix.url = "sourcehut:~alexdavid/jail.nix";

  flake.aspects.nix.homeManager = { config, pkgs, ... }:{
    home.packages = config._.allow-unfree-jailed;
  };
}
