{ config, lib, pkgs, ... }:{
    nixpkgs.overlays = [
      (self: super: {
        alarm-clock = super.writeScriptBin "alarm-clock" ''
          #!${pkgs.nushell}/bin/nu

          # print "Test print"
          # hyprctl dispatch dpms on

          # set volume to 50%
          wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%

          # lower volume = wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          # raise volume = wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+   # -l 2 = 200% max

          ${pkgs.mpv}/bin/mpv --really-quiet ${./bird_forest.mp3}

          # calculate delay (total time / number of steps)
          let delay = ($_duration / $level)
          print $"Starting fade out over ($_duration)..."
          
          # loop from 0 up to the current level, replace 0 by 1 to keep 1% of brighteness
          # 0..$level | each { |iter|
          #   brightnessctl --quiet set 1%-
          #   # print $"Step: ($iter) of ($level)"
          #   sleep $delay
          # }
        '';
      })
    ];
}
