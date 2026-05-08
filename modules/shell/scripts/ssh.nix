{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ssh";

      runtimeInputs = with pkgs; [
        sshs
        openssh
      ];

      text = ''
        if [ $# -eq 0 ]; then
          sshs
        else
          ssh "$*"
        fi
      '';
    })
  ];
}
