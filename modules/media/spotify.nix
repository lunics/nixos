{ inputs, ... }:{
  flake.aspects.media.homeManager = { pkgs, lib, ... }: let
    jail = inputs.jail-nix.lib.init pkgs;

    spotify = jail "spotify" pkgs.spotify (with jail.combinators; [
      network
      gui
      gpu

      (dbus {
        talk = [
          "org.freedesktop.DBus"
          "org.freedesktop.portal.*"
        ];
      })
      (rw-bind (noescape "~/.cache/spotify")  "/cache")
      (rw-bind (noescape "~/.config/spotify") "/config")
    ]);
  in {
    _.allow-unfree-jailed = [ { name = "spotify"; pkg = spotify; } ];
  };
}
