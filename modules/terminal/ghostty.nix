{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    ghostty
  ];

  xdg.configFile."ghostty/config".text = ''
    # get all options: ghostty +show-config --default --docs      # https://ghostty.org/docs/config

    font-size = 18
    # background = #123abc
  '';
}
