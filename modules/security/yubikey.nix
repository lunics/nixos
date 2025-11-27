{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.yubikey {
    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubikey-touch-detector
      yubikey-agent                     # ssh-agent for yubikey
      # yubikey-full-disk-encryption    # doesn't exist
      yubico-pam
      pam_u2f
      age-plugin-yubikey
      # age
      rage        # age in rust
      pcsclite
      yubikey-personalization
    ];

    services = {
      pcscd.enable = true;
      udev.packages = [ pkgs.yubikey-personalization ];
      yubikey-agent.enable = true;   # install the service in user space
        # Every session requires the PIN, every login requires a touch. Setup takes care of PUK and management key
    };

    # programs = {
    #   ssh.startAgent = false;
    #
    #   gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true; };
    # };
  };
}
