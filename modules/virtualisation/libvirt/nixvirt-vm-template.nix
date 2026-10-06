{ inputs, ... }:{
  flake.aspects = { aspects, ... }:{
    nixvirt-vm-linux = {
      includes = with aspects; [
        nixvirt
      ];
      nixos = let
        nixvirt  = inputs.nixvirt.lib;
        vm-name  = "penguin";
        pool-dir = "/var/lib/libvirt/pools/${vm-name}";
        iso      = "/var/lib/libvirt/isos/nixos-minimal.iso";    # set to null once installed
      in {
        systemd.tmpfiles.rules = [ "d ${pool-dir} 0711 root root -" ];

        # this part below is provided by nixvirt
        virtualisation.libvirt.connections."qemu:///system" = {
          # nat bridge 192.168.<subnet_byte>.0/24 with dhcp, keep libvirt's default virbr0 untouched
          networks = [{
            definition = nixvirt.network.writeXML (nixvirt.network.templates.bridge {
              name        = "${vm-name}-net";
              uuid        = "8b66ea79-0e53-42d3-afe0-bd39ed1ceea7";
              bridge_name = "virbr1";
              subnet_byte = 100;
              dhcp_hosts  = [{ mac = "52:54:00:00:00:01"; name = vm-name; ip = "192.168.100.10"; }];
            });
            active  = true;
            restart = null;
          }];

          # warning: any pool not listed here is deleted (its files are kept)
          pools = [{
            definition = nixvirt.pool.writeXML {
              name   = "${vm-name}-pool";
              uuid   = "b0d2bdf5-26b2-4c3f-9457-4ec93ab7c7a3";
              type   = "dir";
              target = { path = pool-dir; };
            };
            active  = true;
            restart = null;
            volumes = [{
              present    = true;
              definition = nixvirt.volume.writeXML {
                name     = "${vm-name}.qcow2";
                capacity = { count = 40; unit = "GiB"; };
                target   = { format = { type = "qcow2"; }; };
              };
            }];
          }];

          domains = [{
            definition = nixvirt.domain.writeXML (nixvirt.domain.templates.linux {
              name          = vm-name;
              uuid          = "d31b12b3-5af3-40c2-9065-def1ea306ca4";
              vcpu          = { count = 4; };
              memory        = { count = 4; unit = "GiB"; };
              storage_vol   = { pool = "${vm-name}-pool"; volume = "${vm-name}.qcow2"; };
              backing_vol   = null;                     # qcow2 base image for a copy-on-write disk
              install_vol   = iso;                      # cdrom, booted before the disk
              bridge_name   = "virbr1";
              net_iface_mac = "52:54:00:00:00:01";      # null = random mac
              virtio_drive  = true;                     # vda on virtio, false = sda on sata
              virtio_video  = true;                     # virtio-gpu with 3d accel, false = qxl
            });
            active  = true;                             # start the vm on activation
            restart = null;                             # restart only when the definition changes
          }];
        };
      };
    };
  };
}
