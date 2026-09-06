{
  flake.aspects.speech-to-text.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [ 
      handy
      wtype       # required by handy for reliable text input
    ];

    _.add_to_startup = [ "handy --start-hidden"];

    wayland.windowManager.hyprland.extraConfig = ''
      hl.bind("CTRL + space", hl.dsp.exec_cmd("handy --toggle-transcription"))
    '';
  };
}
