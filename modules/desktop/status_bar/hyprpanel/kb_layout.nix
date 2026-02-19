{ config, lib, ... }:{ 
  config = lib.mkIf (config._.status_bar == "hyprpanel") {
    home.file.".config/hyprpanel/kb_layout.sh" = {
      executable = true;
      text       = ''
        #!/usr/bin/env bash
        
        source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        
        kb_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .layout')
        
        if [ "$kb_layout" == "us" ]; then
          echo '{"message":"'$kb_layout'"}'
        fi
      '';
    };

    _.hyprpanel_modules = [ ''
      "custom/kb_layout": {
        "label":    "{message}",
        "execute":  "~/.config/hyprpanel/kb_layout.sh",
        "interval": 5000
      },
    '' ];
  };
}
