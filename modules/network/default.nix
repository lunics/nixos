{
  imports = [
    ./bluetooth.nix
    ./iwd.nix
    ./network-manager.nix
    ./network.nix
    ./vpn
    ./dns
  ];

  # network diagnostic tool that combines ping and traceroute into one program
  programs.mtr.enable = true;
}
