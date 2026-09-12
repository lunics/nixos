{
  flake.aspects.yubikey.nixos = {
    services = {
      pcscd.enable         = true;
      yubikey-agent.enable = true;  # install the service in user space, every session requires PIN, every login requires touch
    };

    programs.yubikey-touch-detector = {
      enable     = true;
      libnotify  = true;   # send a desktop notification on touch request
      unixSocket = true;   # expose the notifications on a unix socket
      verbose    = false;
    };

    # programs = {
    #   ssh.startAgent = false;
    #   gnupg.agent = { enable = true; enableSSHSupport = true; };
    # };
  };
}
