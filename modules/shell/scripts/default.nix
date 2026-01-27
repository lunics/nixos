{ pkgs, ... }:
let
  scripts = [ 
    ./catt.nix
    ./gen-pass.nix
    ./passfzf.nix
    ./pkg.nix
    ./disk.nix
    # ./ssh.nix         # KO breaks git actions via SSH
    ./rr.nix
    ./timer.nix
    ./otp.nix
    ./toggle_bt_device.nix
    ./toggle_vpn.nix
    ./_suspend.nix
    ./_poweroff.nix
  ];
in {
  nixpkgs.overlays = map import scripts;

  home.packages = map (name: pkgs.${
    builtins.replaceStrings [ ".nix" ] [ "" ] (   # remove .nix from catt.nix
      builtins.baseNameOf (toString name)         # extract catt.nix from ./catt.nix
    )}) scripts;
}
