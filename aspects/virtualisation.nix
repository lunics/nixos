{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    virtualisation.includes = with aspects; [
      k3s
      k0s
      microvm
      libvirtd
      nixvirt
      docker
      podman
      waydroid
      xen
    ];
  };
}
