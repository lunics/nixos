{ pkgs }: pkgs.writeShellApplication {
  name = "pkg";
  runtimeInputs = with pkgs; [ 
    nh
  ];

  text = ''
    if [[ "$1" = "search" ]]; then
      nh search "$2"
    fi
  '';
}
