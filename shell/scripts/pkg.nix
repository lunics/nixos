{ pkgs }: pkgs.writeShellApplication {
  name = "pkg";
  runtimeInputs = with pkgs; [ 
    nh
  ];

  text = ''
    if [ $# == 0 ]; then
      nh search "$1"
    elif [[ "$1" = "search" ]]; then
      nh search "$2"
    # elif [[ "$1" = "install" ]]; then     -i/i/install
    fi
  '';
}
