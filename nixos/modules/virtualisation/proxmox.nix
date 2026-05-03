# https://github.com/SaumonNet/proxmox-nixos
{ pkgs, lib, ... }:{
  imports = [ proxmox-nixos.nixosModules.proxmox-ve ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "192.168.0.1";
  };

  nixpkgs.overlays = [
    proxmox-nixos.overlays.x86_64-linux
  ];

  # impermanence
  environment.persistence."/persistent".directories = [
    "/var/lib/pve-cluster"
  ];



  # With systemd-networkd
  # Make vmbr0 bridge visible in Proxmox web interface
  services.proxmox-ve.bridges = [ "vmbr0" ];
  
  # Actually set up the vmbr0 bridge
  systemd.network.networks."10-lan" = {
      matchConfig.Name = [ "ens18" ];
      networkConfig = {
      Bridge = "vmbr0";
      };
  };
  
  systemd.network.netdevs."vmbr0" = {
      netdevConfig = {
          Name = "vmbr0";
          Kind = "bridge";
      };
  };
  
  systemd.network.networks."10-lan-bridge" = {
      matchConfig.Name = "vmbr0";
      networkConfig = {
      IPv6AcceptRA = true;
      DHCP = "ipv4";
      };
      linkConfig.RequiredForOnline = "routable";
  };
}
