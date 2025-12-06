{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.devbox {
    home.packages = with pkgs; [
      devbox
    ];

    programs.zsh.initContent = ''
      eval "$(devbox global shellenv)"
    '';
  };
}
