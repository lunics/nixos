{
  flake.aspects.scripts.homeManager = { config, pkgs, ... }:{
    home.packages = [
      (pkgs.writeShellApplication {
        name = "save_env";

        runtimeInputs = [ pkgs.taskwarrior3 pkgs.timewarrior ];    # timew is spawned by the taskwarrior on-modify hook

        text = ''
          ## status can return Stopped even if something is playing
          # if (playerctl status 2>/dev/null) || echo "No player" ; then 
          #   continue
          # else
          #   playerctl pause
          #   # playerctl status | rg "Playing" && playerctl pause
          # fi

          if command -v task &> /dev/null; then
            export TASKDATA=${config._.share}/taskwarrior
            export TASKRC=${config._.dot_config}/taskwarrior/taskw/taskrc
            export TIMEWARRIORDB=${config._.share}/taskwarrior/timewarrior    # the on-modify hook runs timew against it

            if task +ACTIVE &> /dev/null; then
              # hooks.location is expanded from $CONFIG, only exported to zsh, and bulk=0 drops the
              # confirmation asked from 3 tasks on, which no tty can answer here
              task rc.hooks.location=${config._.dot_config}/taskwarrior/hooks rc.bulk=0 +ACTIVE stop &> /dev/null
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
