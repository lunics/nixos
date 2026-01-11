{
  imports = [
    ./libvirt
    ./waydroid.nix
    ./k0s.nix
    ./k3s
    ./xen.nix
    ./podman.nix
    ./docker.nix
    ./microvm
    # ./pci_passthrough
    # ./proxmox.nix
  ];
}
