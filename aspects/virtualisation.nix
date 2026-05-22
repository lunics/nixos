{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    virtualisation.includes = with aspects; [
      k3s
      k0s
      microvm
      libvirt
      docker
      podman
      waydroid
      xen
    ];
  };
}
