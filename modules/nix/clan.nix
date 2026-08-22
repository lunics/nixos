{ inputs, ... }:{
  flake-file.inputs.clan-core = {
    url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };

  imports = [ inputs.clan-core.flakeModules.default ];

  clan = {
    meta.name   = "clan-test";
    meta.domain = "clan-test.lol";
    machines    = {};
  };
}
