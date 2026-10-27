{
  flake.aspects.dns.nixos = {   # KO failed build, 1,6 GB derivation
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

    # DynamicUser unit, the config and the zones live behind the /var/lib symlink
    _.persistent-system.dirs = [
      "/var/lib/private/technitium-dns-server"
    ];
  };
}
