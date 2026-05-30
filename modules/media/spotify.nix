{ inputs, ... }:{
  flake.aspects.media.homeManager = { pkgs, lib, ... }: let
    jail = inputs.jail-nix.lib.init pkgs;

    spotify = jail "spotify" pkgs.spotify (with jail.combinators; [
      network
      gui
      gpu

      (rw-bind (noescape "~/.cache/spotify")  "/cache")
      (rw-bind (noescape "~/.config/spotify") "/config")
    ]);
  in {
    _.allow-unfree-jailed = [ spotify ];
    home.packages = [ spotify ];
  };
}
