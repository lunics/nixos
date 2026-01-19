{
  imports = [
    ./network.nix
    ./network_manager.nix
    ./wifi
    ./bluetooth.nix
    # ./vpn
    ./dns
    ./firewall.nix
    ./systemd.nix
    ./nat.nix
  ];

  # network diagnostic tool that combines ping and traceroute into one program
  programs.mtr.enable = true;
}
