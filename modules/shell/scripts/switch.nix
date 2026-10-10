{
  flake.aspects.scripts.homeManager = { config, lib, pkgs, ... }:
  let
    hosts = config._.flake-hosts;
    user  = config._.user;
  in {
    home.packages = [
      (pkgs.writers.writeNuBin "switch" {
        makeWrapperArgs = [
          "--prefix" "PATH" ":" "${lib.makeBinPath [ pkgs.home-manager ]}"
        ];
      } ''
        let flake = "${hosts}"

        if ($flake | is-empty) {
          error make --unspanned { msg: "_.flake-hosts is not set" }
        }

        # a failing external command aborts the script, which keeps the && semantics
        nix flake update nixos --flake $flake
        home-manager switch --flake $"($flake)#${user}@(sys host | get hostname)"
      '')
    ];
  };
}
