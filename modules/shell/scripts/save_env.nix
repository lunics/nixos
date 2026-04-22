{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "save_env";

      text = ''
        if playerctl status | rg -s Playing; then 
          playerctl pause
        fi

        if which task; then
          export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
          export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

          if task +active &> /dev/null; then
            task +active stop &> /dev/null
          fi
        fi

        if systemctl is-active --quiet --user pomodoro.service; then
          echo "" > /tmp/pomodoro_cycle
          systemctl --user stop pomodoro.service
        fi

        # only useful when ran manually
        if systemctl is-active --quiet --user sync_browser_profile@$USER.service; then
          systemctl --user stop sync_browser_profile@$USER.service
        fi

        if ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh; then
          echo -e "\e[1;32mTmux saved\e[0m"
        else
          echo -e "\e[1;31mTmux save failed\e[0m"
          exit
        fi
      '';
    })
  ];
}
