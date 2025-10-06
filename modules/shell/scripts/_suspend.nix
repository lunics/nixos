{ pkgs }: pkgs.writeShellApplication {
  name = "_suspend";

  excludeShellChecks = [ "SC2086" "SC2046" "SC1091" ];

  text = ''
    if which task; then
      export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
      export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

      task +ACTIVE stop || true
    fi

    echo "" > /tmp/pomodoro_cycle
    systemctl --user restart pomodoro.timer
    systemctl --user restart pomodoro.service

    systemctl suspend
  '';
}
