{ pkgs }: pkgs.writeShellApplication {
  name = "catt";

  text = ''
    if [ -f "$1" ]; then

      if echo "$1" | grep .gz; then
        zcat "$1"
      else
        bat "$1"
      fi
    else
      if ! bat "$(which "$1" 2> /dev/null)" 2> /dev/null; then
        echo "$1 can't be displayed"
      fi
    fi
  '';
}
