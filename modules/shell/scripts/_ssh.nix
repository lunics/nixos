# KO breaks git actions via SSH
{
  flake.aspects.scripts.homeManager = { pkgs, ... }:{
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
  };
}
