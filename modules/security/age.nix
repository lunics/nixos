{
  flake.aspects.age.homeManager = { config, pkgs, ... }:{
    home = {
      packages = with pkgs; [
        rage    # age in rust
        # age
      ];

      file.".config/age/identities".source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.age-identities.path;
    };

    assertions = [{
      assertion = config.sops.secrets ? age-identities;
      message   = "sops: missing age-identities secret";
    }];
  };
}
