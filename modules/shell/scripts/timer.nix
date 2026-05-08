{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "timer";

      runtimeInputs = with pkgs; [
        coreutils   # to avoid sleep issue
        termdown
        dunst
        libnotify
      ];

      text = ''
        if [ $# -eq 0 ]; then
          seconds=0              # might be used as a delay
          while true; do
            echo -ne "\rtimer: $(date -u -d @$seconds +%H:%M:%S)"
            sleep 1
            ((seconds+=1))
          done
        else
          termdown "$1"
        fi
        
        notify-send --timeout=3000 "Timer" "Time finished"
      '';
    })
  ];
}
