{
  flake.aspects = { aspects, ... }:{
    incus-vm-linux = {
      includes = with aspects; [
        kvm
        incus
      ];
      nixos = { config, lib, ... }:
      let
        incus   = config.virtualisation.incus.package;
        vms     = lib.attrValues config._.incus-vms;
        network = "incus-vms";                          # also the bridge interface name, 15 chars max
        pool    = "incus-vms";
      in lib.mkIf (vms != []) {
        # preseed has no instances, it declares the shared network and pool and one profile per vm
        virtualisation.incus.preseed = {
          networks = [{
            name   = network;
            type   = "bridge";
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat"     = "true";
              "ipv6.address" = "none";
            };
          }];

          storage_pools = [{
            name   = pool;
            driver = "dir";                             # btrfs, zfs, lvm for snapshots and copy-on-write
          }];

          profiles = map (vm: {
            name   = vm.name;
            config = {
              "limits.cpu"          = toString vm.cpu;
              "limits.memory"       = vm.memory;
              "security.secureboot" = lib.boolToString vm.secureboot;
            };
            devices = {
              root = { type = "disk"; path = "/"; pool = pool; size = vm.disk; };
              eth0 = { type = "nic"; name = "eth0"; network = network; }
                // lib.optionalAttrs (vm.hwaddr != null) { hwaddr         = vm.hwaddr; }
                // lib.optionalAttrs (vm.ip     != null) { "ipv4.address" = vm.ip; };
            };
          }) vms;
        };

        networking.firewall.trustedInterfaces = [ network ];    # dhcp and dns from incus on the bridge

        # creates each vm once, then only starts it, deleting it is left to incus delete
        systemd.services = lib.listToAttrs (map (vm: lib.nameValuePair "incus-vm-${vm.name}" {
          wantedBy = [ "multi-user.target" ];
          after    = [ "incus-preseed.service" "network-online.target" ];
          requires = [ "incus-preseed.service" ];
          wants    = [ "network-online.target" ];       # the image is downloaded on first launch
          serviceConfig = {
            Type            = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            ${incus}/bin/incus info ${vm.name} >/dev/null 2>&1 \
              || ${incus}/bin/incus init ${vm.image} ${vm.name} --vm --profile ${vm.name}
            ${incus}/bin/incus info ${vm.name} | grep -q '^Status: RUNNING' \
              || ${incus}/bin/incus start ${vm.name}
          '';
        }) vms);
      };
    };
  };
}
