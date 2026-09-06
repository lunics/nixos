{
  flake.aspects.speech-to-text.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [ 
      handy
      wtype       # required by handy for reliable text input
    ];
  };
}
