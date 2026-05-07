{
  flake.aspects.security.nixos = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.yubikey {
      environment.systemPackages = with pkgs; [
        yubikey-manager
        yubikey-touch-detector
        yubikey-agent         # ssh-agent for yubikey
        yubico-pam
        pam_u2f
        age-plugin-yubikey
        rage                  # age in rust
        pcsclite
        yubikey-personalization
        # yubikey-full-disk-encryption
      ];

      services = {
        pcscd.enable                 = true;
        udev.packages                = [ pkgs.yubikey-personalization ];
        yubikey-agent.enable         = true;  # install the service in user space, every session requires PIN, every login requires touch
      };

      # programs = {
      #   ssh.startAgent = false;
      #   gnupg.agent = { enable = true; enableSSHSupport = true; };
      # };
    };
  };
}
