{ pkgs, ... }:{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "flake-update";
      text = ''
        echo "Hello from my script!"
      '';
    })
  ];
}
