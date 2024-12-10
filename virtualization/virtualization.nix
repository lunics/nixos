{ pkgs, ... }:{

  virtualisation = {
    waydroid.enable = true;

    # containerd.enable = true;

  };

  environment.systemPackages = with pkgs; [
    # nerdctl

    # firecracker
    # firectl
    # flintlock

    # distrobox
    qemu

    # podman-compose
    # podman-tui

    # lazydocker
    # docker-credential-helpers
  ];
}
