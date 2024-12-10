{ pkgs, ... }:{

  virtualisation = {
    waydroid.enable = true;

    # containerd.enable = true;

  };

  # environment.systemPackages = with pkgs; [
  #   nerdctl
  #
  #   firecracker
  #   firectl
  #   flintlock
  #
  #   distrobox
  #
  #   podman-compose
  #   podman-tui
  #
  #   lazydocker
  #   docker-credential-helpers
  # ];
}
