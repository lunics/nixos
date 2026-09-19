{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";   # main branch = stable
  };
  
  flake.aspects.raspberry-pi.nixos = {
    nixConfig = {
      extra-substituters = [
        "https://nixos-raspberrypi.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
      ];
    };
  };

  # class resolved by make_raspberry-pi, the generic nixos aspects never reach it
  flake.aspects.raspberry-pi.nixos-raspberrypi = { lib, pkgs, ... }:{
    console = {
      earlySetup = true;                                                            # font up before stage-2
      font       = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u16n.psf.gz";

      # tango palette, the default blues are unreadable on a tty
      colors = lib.mkDefault [
        "000000" "CC0000" "4E9A06" "C4A000" "3465A4" "75507B" "06989A" "D3D7CF"     # normal
        "555753" "EF2929" "8AE234" "FCE94F" "739FCF" "AD7FA8" "34E2E2" "EEEEEC"     # bright
      ];
    };
  };
}
