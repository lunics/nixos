{
  flake.aspects.nix.homeManager = { config, lib, pkgs, ... }:{
    home.packages = with pkgs; [
      deploy-rs
      nixos-anywhere
      # nix-init          # generate Nix packages from URLs
      # comma             # to runs nix software without installing it
    ];

    nixpkgs = {
      config = {
        allowUnfree = false;
        allowUnfreePredicate = p: builtins.elem (lib.getName p) (map lib.getName config._.allow-unfree);
        allowBroken = false;
      };
      # overlays = null;
    };
  };
}
