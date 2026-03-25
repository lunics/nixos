{ config, lib, ... }:{
  imports = [
    ./static_allocation.nix
    # ./dynamic_allocation.nix
  ];

  config = lib.mkIf config._.microvm.enable {
    networking.useNetworkd = true;     # alias of systemd.network.enable = true;

    # files generated in /etc/systemd/network
    systemd.network = {
      enable = true;
      links  = {};
      config = {
        addRouteTablesToIPRoute2 = true;
        networkConfig = {
          IPv6PrivacyExtensions = config._.microvm.ipv6;
        };
        routeTables  = {};
        dhcpV6Config = {};
        dhcpV4Config = {};
      };
    };
  };
}
