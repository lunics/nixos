{
  home.file.".config/hyprpanel/pomodoro.sh" = {
    executable = true;
    text     = ''
      #!/usr/bin/env bash
      
      json_file=/tmp/pomodoro.json
      
      cycle_count=$(jq -r '.cycle_count' $json_file)
      work=$(jq -r '.work' $json_file)
      pause=$(jq -r '.pause' $json_file)
      
      if systemctl --user is-active --quiet pomodoro.service; then
        if [ $work != 0 ]; then
          echo '{"message":"🍅  '$cycle_count' : '$work'm"}'
        else
          echo '{"message":"🍅  '$cycle_count' : \e[1;32m'$pause'm\e[0m"}'
        fi
      fi
    '';
  };
}
