{
  virtualisation.podman = {
    enable = false;
    dockerCompat = true;   # Create a "docker" alias for podman, to use it as a drop-in replacement
    defaultNetwork.settings.dns_enabled = true;  # Required for containers under podman-compose to be able to talk to each other.
  };
}
