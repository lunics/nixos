{
  flake.aspects.scripts.homeManager = { config, pkgs, ... }:{
    home.packages = [
      (pkgs.writeShellApplication {
        name = "save_env";

        text = ''
          ## status can return Stopped even if something is playing
          # if (playerctl status 2>/dev/null) || echo "No player" ; then 
          #   continue
          # else
          #   playerctl pause
          #   # playerctl status | rg "Playing" && playerctl pause
          # fi

          if which task &> /dev/null; then
            export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
            export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

            if task +ACTIVE &> /dev/null; then
              task +ACTIVE stop &> /dev/null
              echo -e "\e[1;32mTaskw stopped\e[0m"
            fi
          fi

          if systemctl is-active --quiet --user pomodoro.service; then
            echo "" > /tmp/pomodoro_cycle
            systemctl --user stop pomodoro.service
            echo -e "\e[1;32mPomodoro stopped\e[0m"
          fi

          # only useful when ran manually, because service already manages it
          if systemctl is-active --quiet --user sync_browser_profile@"$USER".service; then
            systemctl --user stop sync_browser_profile@"$USER".service
            echo -e "\e[1;32mFirefox profile saved\e[0m"
          fi

          if [ -f /run/user/${toString config._.user_id}/tmux-${toString config._.user_id} ] && ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh; then
            echo -e "\e[1;32mTmux saved\e[0m"
          else
            echo -e "\e[1;31mTmux save failed\e[0m"
            exit
          fi
        '';
      })
    ];
  };
}
