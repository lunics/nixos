{
  flake.aspects.obs.homeManager = { config, lib, pkgs, ... }:{
    _.persistent-home.dirs = lib.mkIf config.programs.obs-studio.enable [ ".config/obs-studio" ];

    programs.obs-studio = {
      enable  = false;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
        obs-backgroundremoval
      ];
    };
  };
}
