{ pkgs, ... }:{

  virtualisation = {
    # containerd.enable = true;

    # docker = {
    #   enable = true;
    #   rootless = {
    #     enable = true;
    #     setSocketVariable = true;
    #   };
    # };
    # users.extraGroups.docker.members = [ "lunics" ];

    podman = {
      enable = false;
      dockerCompat = true;   # Create a "docker" alias for podman, to use it as a drop-in replacement
      defaultNetwork.settings.dns_enabled = true;  # Required for containers under podman-compose to be able to talk to each other.
    };
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
