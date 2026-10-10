{
  flake.aspects = { aspects, ... }:{
    incus-vm-linux = {
      includes = with aspects; [
        kvm
        incus
      ];
      nixos = { config, ... }:
      let
        incus   = config.virtualisation.incus.package;
        vm-name = "penguin";
        image   = "images:nixos/unstable";              # incus image list images: nixos
        network = "${vm-name}-net";                     # also the bridge interface name, 15 chars max
        pool    = "${vm-name}-pool";
      in {
        # preseed has no instances, it only declares the network, the pool and the profile
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

          profiles = [{
            name   = vm-name;
            config = {
              "limits.cpu"          = "4";
              "limits.memory"       = "4GiB";
              "security.secureboot" = "false";          # the nixos images are not signed
            };
            devices = {
              root = { type = "disk"; path = "/"; pool = pool; size = "40GiB"; };
              eth0 = {
                type           = "nic";
                name           = "eth0";
                network        = network;
                hwaddr         = "00:16:3e:00:00:01";
                "ipv4.address" = "10.0.100.10";         # static dhcp lease
              };
            };
          }];
        };

        networking.firewall.trustedInterfaces = [ network ];    # dhcp and dns from incus on the bridge

        # creates the vm once, then only starts it, deleting it is left to incus delete
        systemd.services."incus-vm-${vm-name}" = {
          wantedBy = [ "multi-user.target" ];
          after    = [ "incus-preseed.service" "network-online.target" ];
          requires = [ "incus-preseed.service" ];
          wants    = [ "network-online.target" ];       # the image is downloaded on first launch
          serviceConfig = {
            Type            = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            ${incus}/bin/incus info ${vm-name} >/dev/null 2>&1 \
              || ${incus}/bin/incus init ${image} ${vm-name} --vm --profile ${vm-name}
            ${incus}/bin/incus info ${vm-name} | grep -q '^Status: RUNNING' \
              || ${incus}/bin/incus start ${vm-name}
          '';
        };
      };
    };
  };
}
