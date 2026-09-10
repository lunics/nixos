{
  flake.aspects.networkd.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      networking = {
        useNetworkd = true;   # alias of systemd.network.enable = true
        # networkd owns the microvm bridge and its TAPs, NetworkManager must not touch them
        networkmanager.unmanaged = [ "interface-name:microvm" "interface-name:mvm-*" ];
      };

      # files generated in /etc/systemd/network
      systemd.network = {
        enable = true;
        config = {
          addRouteTablesToIPRoute2 = true;
          networkConfig = {
            IPv6PrivacyExtensions = config._.net.ipv6;
          };
          routeTables  = {};
          dhcpV6Config = {};
          dhcpV4Config = {};
        };
        # off by default: with bridge-nat the microvm bridge has no carrier while no VM
        # runs, so --any stalls the switch; aspects owning a real link re-enable it
        wait-online = {
          enable       = lib.mkDefault false;
          anyInterface = lib.mkDefault config.networking.useDHCP;
          timeout      = 30;
          extraArgs    = [];
          ignoredInterfaces = [ "mvm-*" ];
        };
        links    = {};
        netdevs  = {};
        networks = {};
      };
    };
  };
}
