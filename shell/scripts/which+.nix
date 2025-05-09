{ pkgs }: pkgs.writeShellApplication {
  name = "which+";

  text = ''
    if grep bash "$1" &> /dev/null; then
      cat "$1"
    else 
      which  "$1"
    fi
  '';
}
