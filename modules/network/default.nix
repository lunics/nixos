{
  imports = [
    ./network.nix
    ./network_manager.nix
    ./wifi
    ./bluetooth.nix
    # ./vpn
    ./dns
    ./firewall.nix
  ];

  # network diagnostic tool that combines ping and traceroute into one program
  programs.mtr.enable = true;
}
