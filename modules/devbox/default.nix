{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    devbox
  ];

  programs.zsh.initContent = ''
    eval "$(devbox global shellenv)"
  '';
}
