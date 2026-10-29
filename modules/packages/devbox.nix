{
  flake.aspects.packages.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.devbox {
      _.persistent-home.dirs = [ ".local/share/devbox" ];    # global profile

      home.packages = with pkgs; [
        devbox
      ];

      programs.zsh.initContent = ''
        eval "$(devbox global shellenv)"
      '';
    };
  };
}
