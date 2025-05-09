{ pkgs }: pkgs.writeShellApplication {
  name = "disk";
  runtimeInputs = with pkgs; [ 
    coreutils   # df
    dysk
  ];

  text = ''
    lsblk
    echo
    df -h
    echo
    dysk
  '';
}
