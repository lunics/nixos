{ config, lib, pkgs, ... }: with lib;
let
  gopass-jsonapi-zen = pkgs.gopass-jsonapi.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner  = "lunics";
      repo   = "gopass-jsonapi";
      rev    = "c9da8947c2187db9d23a4b6c48bdcec2b0cfef31";
      sha256 = "sha256-qA+ntmohW+B5iFQuqbXFYuarum0YzeQlAXNyr2TJQZM=";
    };
  });
in {
  config = mkIf (config._.pass_manager == "gopass") {
    home.packages = with pkgs; [ 
      gopass
      # git-credential-gopass     # to cache your git-credentials with gopass
      # gopass-summon-provider    # inject secrets as environment variables
      # gopass-hibp               # gopass haveibeenpwnd.com integration
    ] ++ optionals (config._.browser == "firefox") [
      gopass-jsonapi              # gopass browser bindings
    ] ++ optionals (config._.browser == "zen") [ 
      gopass-jsonapi-zen
    ];
  };
}
