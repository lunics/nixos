{
  # nix.channel.enable = lib.mkForce true;
  boot.initrd.systemd.enable = true;

  imports = [
    ./libvirt
    # ./xen.nix
    # ./k3s
    # ./podman.nix
    # ./docker.nix
    # ./containerd.nix
    # ./waydroid.nix
  ];
}
