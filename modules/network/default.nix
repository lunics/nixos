{
  imports = [
    ./network.nix
    ./network_manager.nix
    # ./wifi_profiles.nix
    ./iwd.nix
    ./bluetooth.nix
    # ./vpn
    ./dns
  ];

  # network diagnostic tool that combines ping and traceroute into one program
  programs.mtr.enable = true;
}
