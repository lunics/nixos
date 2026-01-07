{
  home.file.".config/hyprpanel/pomodoro.sh" = {
    executable = true;
    text     = ''
      #!/usr/bin/env bash
      
      json_file=/tmp/pomodoro.json
      
      cycle=$(jq -r '.cycle' $json_file)
      work=$(jq -r  '.current_work' $json_file)
      break=$(jq -r '.break' $json_file)
      
      if systemctl --user is-active --quiet pomodoro.service; then
        if [ $work != 0 ]; then
          echo '{"message":"🍅  '$cycle' : '$work'm"}'
        else
          echo '{"message":"🍅  '$cycle' : \e[1;32m'$break'm\e[0m"}'
        fi
      fi
    '';
  };
}
