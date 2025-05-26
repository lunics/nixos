{ pkgs }: pkgs.writeShellApplication {
  name = "pkg";
  runtimeInputs = with pkgs; [ 
    nh
  ];

  text = ''
    if [[ "$1" = "search" ]]; then
      nh search "$2"
    elif [[ "$1" = "run" ]]; then     ## or -i/i/install
      nix-shell -p "$2" --run \""$2"\"
    else
      nh search "$1"
    fi
  '';
}
