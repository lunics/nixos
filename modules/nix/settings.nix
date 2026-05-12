{
  flake.aspects.nix-settings = let
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    require-sigs = true;                  # will only download binaries cryptographically signed
    substituters = [
      "https://hyprland.cachix.org"
      "https://microvm.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    ];
    cores    = 0;                         # 0 means use all available CPU cores
    max-jobs = "auto";                    # will use all available logical cores
    auto-optimise-store = true;           # replaces identical files in the store with hard links
    sandbox = true;                       # builds performed in a sandboxed environment, prevents impurities
  in {
    nixos = { config, ... }:{
      nix.settings = {
        allowed-users = [ "*" ];          # users allowed to connect to the Nix daemon, @group to add new group
        trusted-users = [ "root" ]        # users that have additional rights, required for deploy-rs
          ++config._.nix.trusted-users;

        inherit experimental-features;

        access-tokens = [
          "github.com=${config._.github_token}"     # required to avoid Github API rate limit exceeded
        ];

        inherit require-sigs;
        inherit substituters;
        trusted-substituters = substituters;    # binary cache URLs that non-root users can use
        inherit trusted-public-keys;
        inherit cores max-jobs;
        inherit auto-optimise-store;
        inherit sandbox;
      };
    };

    homeManager = { config, ... }:{
      nix.settings = {
        inherit experimental-features;

        access-tokens = [
          "github.com=${config._.github_token}"
        ];

        inherit require-sigs;
        inherit substituters;
        inherit trusted-public-keys;
        inherit cores max-jobs;
        inherit auto-optimise-store;
        inherit sandbox;
      };
    };
  };
}
