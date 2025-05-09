{ pkgs }: pkgs.writeShellApplication {
  name = "dis";
  runtimeInputs = with pkgs; [ 
    coreutils   # df
    dysk
  ];

  text = ''
    dysk
    echo
    df -h
    echo
    lsblk
  '';
}
