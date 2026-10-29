{
  flake.aspects.tidal = {
    nixos = { config, ... }:{
      users.users.${config._.user}.extraGroups = [ "audio" ];
    };

    homeManager = { pkgs, ... }:{
      _.persistent-home.dirs = [
        ".local/share/SuperCollider"    # quarks, SuperDirt
        ".config/cabal"
        ".local/state/cabal"            # cabal store, where the tidal library is installed
      ];

      home.packages = with pkgs; [
        jack2
        qjackctl
        cabal-install 
        supercollider
        supercolliderPlugins.sc3-plugins
        ghc
      ];
    };
  };
}
