{
  flake.aspects.client_mail.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [ 
      thunderbird
      birdtray      # system tray notification icon for Thunderbird
    ];
  };
}
