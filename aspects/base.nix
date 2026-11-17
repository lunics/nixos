{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    base.includes = with aspects; [
      options
      facter
      disk
      swap
      persistent
      boot 
      systemd-boot
      nix
      hardware
      kernel
      etc
      network
      network-manager
      firewall
      dns
      mdns
      location
      ntp
      programs
      polkit
      sshd
      sudo
      services
      secrets
    ];
  };
}
