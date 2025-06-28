{ pkgs, ... }:{
  programs.obs-studio = {
    enable  = false;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-backgroundremoval
    ];
  };
}
