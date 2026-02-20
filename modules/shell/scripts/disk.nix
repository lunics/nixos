{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "disk";

      runtimeInputs = with pkgs; [ 
        duf
        dysk
      ];

      text = ''
        duf --hide special
        echo
        dysk
      '';
    })
  ];
}
