{ pkgs }: pkgs.writeShellApplication {
  name = "timer";
  runtimeInputs = with pkgs; [
    coreutils   # to avoid sleep issue
    termdown
    dunst
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
    
    dunstify --timeout=3000 "Timer" "Time finished"
  '';
}
