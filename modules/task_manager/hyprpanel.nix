{ config, lib, ... }:{ 
  config = lib.mkIf (config._.status_bar == "hyprpanel") {
    home.file."/.config/hyprpanel/taskwarrior.sh" = {
      executable = true;
      text       = ''
        #!/usr/bin/env bash
        
        source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        
        if task +ACTIVE >& /dev/null; then
          project=$(task +ACTIVE _project)
          time=$(task +ACTIVE rc.verbose=nothing | awk '{print $NF}')
          echo '{"message":"'$project' '$time'"}'
        else
          echo '{"message":""}'
        fi
      '';
    };

    _.hyprpanel_modules = [ ''
      "custom/taskwarrior": {
        "label":    "{message}",
        "execute":  "~/.config/hyprpanel/taskwarrior.sh",
        "interval": 5000
      },
    '' ];
  };
}
