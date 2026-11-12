{
  flake.aspects.nix.homeManager = { config, lib, pkgs, ... }:{
    home.packages = with pkgs; [
      deploy-rs
      vim
      # nix-init          # generate Nix packages from URLs
      # comma             # to runs nix software without installing it
    ] ++ config._.allow-unfree;

    # standalone only, as a nixos submodule home-manager reuses the system pkgs and its config
    nixpkgs = lib.mkIf (!config.submoduleSupport.enable) {
      config = {
        allowUnfreePredicate = p: let
          name = lib.getName p;
        in
          builtins.elem name (map lib.getName config._.allow-unfree)
          || builtins.elem name (map (e: e.name) config._.allow-unfree-jailed);
        allowUnfree = false;
        allowBroken = false;
      };
      # overlays = null;
    };
  };
}
