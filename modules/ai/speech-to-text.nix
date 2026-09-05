{
  flake.aspects.speech-to-text.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [ 
      handy
    ];
  };
}
