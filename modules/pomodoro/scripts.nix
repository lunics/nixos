{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "toggle_pomodoro";
      text = ''
        echo "0" > /tmp/pomodoro_cycle    # reset cycle in all conditions
        
        if [ "$(systemctl --user status pomodoro.timer | rg -so inactive)" = "inactive" ]; then
          systemctl --user restart pomodoro.timer       # start keep previous time left before triggering
          systemctl --user restart pomodoro.service
        else
          systemctl --user stop pomodoro.timer
          systemctl --user stop pomodoro.service
          notify-send -t 3000 "Pomodoro stopped"
        fi
      '';
    })
    
    (pkgs.writeShellApplication {
      name = "reset_pomodoro";
      text = ''
        echo "" > /tmp/pomodoro_cycle
        systemctl --user restart pomodoro.timer
      '';
    })
  ];
}
