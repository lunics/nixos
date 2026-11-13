{
  # osConfig stays out of the formals: a declared module arg ignores its default and breaks HM standalone
  flake.aspects.age.homeManager = { config, lib, pkgs, ... }@args:
  let
    clan-key   = args.osConfig.clan.core.vars.generators.age-identities.files.key.path or null;
    sops-key   = config.sops.secrets.age-identities.path or null;
    identities = if clan-key != null then clan-key else sops-key;
  in {
    home = {
      packages = with pkgs; [
        rage    # age in rust
        # age
      ];

      file.".config/age/identities" = lib.mkIf (identities != null) {
        source = config.lib.file.mkOutOfStoreSymlink identities;
      };
    };

    assertions = [{
      assertion = identities != null;
      message   = "age: missing age-identities (clan vars or sops)";
    }];
  };
}
