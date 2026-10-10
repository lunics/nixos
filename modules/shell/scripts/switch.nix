{
  flake.aspects.scripts.homeManager = { config, lib, pkgs, ... }:
  let
    hosts = config._.flake-hosts;
    user  = config._.user;
  in {
    options._.flake-hosts = lib.mkOption {
      type    = lib.types.str;    # absolute path of the nixos-hosts flake
      default = "";
    };

    config.home.packages = [
      (pkgs.writers.writeNuBin "switch" {
        makeWrapperArgs = [
          "--prefix" "PATH" ":" "${lib.makeBinPath [ pkgs.home-manager ]}"
        ];
      } ''
        def main [target: string = "hm"] {
          # checked before the update so a typo cannot touch the lock file
          if $target not-in ["nixos", "hm"] {
            error make --unspanned { msg: $"unknown target '($target)': expected 'nixos' or 'hm'" }
          }

          let flake = "${hosts}"

          if ($flake | is-empty) {
            error make --unspanned { msg: "_.flake-hosts is not set" }
          }

          # a failing external command aborts the script, which keeps the && semantics
          nix flake update nixos --flake $flake

          let host = (sys host | get hostname)

          if $target == "hm" {
            home-manager switch --flake $"($flake)#${user}@($host)"
          } else {
            sudo nixos-rebuild switch --flake $"($flake)#($host)"
          }
        }
      '')
    ];
  };
}
