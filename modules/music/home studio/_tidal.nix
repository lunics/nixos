{
  flake.aspects.tidal = {
    nixos = {
      sudo usermod -a -G audio $USER
    };

    homeManager = { pkgs, ... }:{
      home.packages = with pkgs; [
        jack2
        qjackctl
        # cabal-install 
        supercollider
        supercolliderPlugins.sc3-plugins
      ];

      git ls-remote https://codeberg.org/musikinformatik/SuperDirt.git | grep tags | tail -n1 | awk -F/ '{print $NF}'
    };
  };
}
