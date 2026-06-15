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
      ];

      # get superdirt latest version: v1.7.4
      # git ls-remote https://codeberg.org/musikinformatik/SuperDirt.git | grep tags | tail -n1 | awk -F/ '{print $NF}'
    };
  };
}
