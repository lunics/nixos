{
  flake.aspects.tidal = {
    nixos = { config, ... }:{
      users.users.${config._.user}.extraGroups = [ "audio" ];
    };

    homeManager = { pkgs, ... }:{
      home.packages = with pkgs; [
        jack2
        qjackctl
        cabal-install 
        supercollider
        supercolliderPlugins.sc3-plugins
        ghc
      ];
  };
}
