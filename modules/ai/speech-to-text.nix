{
  flake.aspects.speech-to-text.homeManager = { pkgs, ... }:
  let
    # handy needs a live mic, so unmute around the transcription and restore the mute state after it
    toggle-transcription = pkgs.writeScriptBin "toggle-transcription" ''
      #!${pkgs.nushell}/bin/nu

      let state   = "/tmp/handy-unmuted-mic"
      let handy   = "${pkgs.handy}/bin/handy"
      let wpctl   = "${pkgs.wireplumber}/bin/wpctl"
      let is_mute = (^$wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | str contains "MUTED")

      if $is_mute {
        ^$wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        touch $state
        ^$handy --toggle-transcription
      } else {
        ^$handy --toggle-transcription
        if ($state | path exists) {
          rm -f $state
          ^$wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        }
      }
    '';
  in
  {
    home.packages = with pkgs; [ 
      handy
      wtype       # required by handy for reliable text input
    ];

    _.add_to_startup = [ "handy --start-hidden"];

    wayland.windowManager.hyprland.extraConfig = ''
      hl.bind("CTRL + space", hl.dsp.exec_cmd("${toggle-transcription}/bin/toggle-transcription"))
    '';
  };
}
