{
  flake.aspects.incus.nixos = { config, pkgs, ... }:{
    virtualisation.incus = {
      enable            = true;
      package           = pkgs.incus-lts;               # pkgs.incus for the feature release
      lxcPackage        = config.virtualisation.lxc.package;
      clientPackage     = config.virtualisation.incus.package.client;
      softDaemonRestart = true;                         # stop incus.service without affecting running instances
      socketActivation  = false;                        # start incus.service on demand instead of at boot
      startTimeout      = 600;                          # seconds to wait for incusd to be ready
      useACMEHost       = null;                         # existing security.acme.certs host used for TLS
      storage.truenas.enable = false;                   # requires services.openiscsi.enable
      agent.enable           = false;                   # only inside an incus guest vm

      ui = {
        enable  = false;
        package = pkgs.incus-ui-canonical;
      };

      # re-applied at each activation, creates or overwrites entities but never removes them
      preseed = null;
      # preseed = {
      #   networks = [{
      #     name   = "incusbr0";
      #     type   = "bridge";
      #     config = {
      #       "ipv4.address" = "10.0.100.1/24";
      #       "ipv4.nat"     = "true";
      #     };
      #   }];
      #   profiles = [{
      #     name    = "default";
      #     devices = {
      #       eth0 = { name = "eth0"; network = "incusbr0"; type = "nic"; };
      #       root = { path = "/"; pool = "default"; size = "35GiB"; type = "disk"; };
      #     };
      #   }];
      #   storage_pools = [{
      #     name   = "default";
      #     driver = "dir";
      #     config.source = "/var/lib/incus/storage-pools/default";
      #   }];
      # };
    };

    networking.nftables.enable = true;                  # incus asserts nftables when the firewall is enabled

    users.extraGroups.incus-admin.members = [ "${config._.user}" ];
  };
}
