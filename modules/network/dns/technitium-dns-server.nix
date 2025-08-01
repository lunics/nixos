{
  services.technitium-dns-server = {
    enable           = true;
    openFirewall     = true;
    firewallTCPPorts = [
      53
      5380
      53443
    ];
    firewallUDPPorts = [
      53
    ];

    # package = pkgs.technitium-dns-server;
  };
}
