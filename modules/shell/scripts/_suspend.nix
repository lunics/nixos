{ pkgs }: pkgs.writeShellApplication {
  name = "_suspend";
  excludeShellChecks = [ "SC2086" "SC2046" "SC1091" ];

  text = ''
    if which task; then
      export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
      export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

      task +ACTIVE stop || true
    fi

    if systemctl is-active --quiet --user pomodoro.service; then
      echo "" > /tmp/pomodoro_cycle
      systemctl --user restart pomodoro.timer
      systemctl --user restart pomodoro.service
    fi

    ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh

    systemctl suspend
  '';
}
