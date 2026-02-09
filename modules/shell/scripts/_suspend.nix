self: super: {
  _suspend = super.writeShellApplication {
    name = "_suspend";

    text = ''
      if playerctl status | rg -s Playing; then 
        playerctl pause
      fi

      if which task; then
        export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
        export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

        task +ACTIVE stop || true
      fi

      if systemctl is-active --quiet --user pomodoro.service; then
        echo "" > /tmp/pomodoro_cycle
        systemctl --user restart pomodoro.service
      fi

      ${super.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh

      systemctl suspend
    '';
  };
}
