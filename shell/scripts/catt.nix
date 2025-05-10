{ pkgs }: pkgs.writeShellApplication {
  name = "catt";

  text = ''
    if [ -f "$1" ]; then

      if echo $1 | grep .gz; then
        zcat "$1"
      else
        bat "$1"
      fi
    else
      bat "$(which $1)" 2> /dev/null

      if [ $? -ne 0 ]; then
        echo "$1 can't be displayed"
      fi
    fi
  '';
}
