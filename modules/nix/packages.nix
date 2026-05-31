{
  flake.aspects.nix.homeManager = { config, lib, pkgs, ... }:{
    home.packages = with pkgs; [
      deploy-rs
      nixos-anywhere
      vim
      # nix-init          # generate Nix packages from URLs
      # comma             # to runs nix software without installing it
    ] ++ config._.allow-unfree;

    nixpkgs = {
      config = {
        allowUnfreePredicate = p: let 
          name = lib.getName p; 
        in
          builtins.elem name (map lib.getName config._.allow-unfree) ||
          builtins.elem name config._.allow-unfree-jailed;
        allowUnfree = false;
        allowBroken = false;
      };
      # overlays = null;
    };
  };
}
