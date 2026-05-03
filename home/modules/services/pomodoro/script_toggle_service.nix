{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.pomodoro){
    home.packages = [
      (pkgs.writeShellApplication {
        name = "toggle_pomodoro";
        text = ''
          if [ "$(systemctl --user status pomodoro.service | rg -so inactive)" = "inactive" ]; then
            systemctl --user start pomodoro.service
          else
            systemctl --user stop pomodoro.service
            notify-send -t 3000 "Pomodoro stopped"
          fi
        '';
      })
      
      (pkgs.writeShellApplication {
        name = "reset_pomodoro";
        text = ''
          rm /tmp/pomodoro.json
          systemctl --user restart pomodoro.service
        '';
      })
    ];
  };
}
