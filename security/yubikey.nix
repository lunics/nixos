{ pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-touch-detector
    yubikey-agent                     # ssh-agent for yubikey
    # yubikey-full-disk-encryption    # doesn't exist
    yubico-pam
    # pam-u2f           ## not available
    age-plugin-yubikey
    # age
    rage      # age in rust
    passage
    pcsclite
  ];

  services.pcscd.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.yubikey-agent.enable = true;   # install service in user space
    # Every session requires the PIN, every login requires a touch. Setup takes care of PUK and management key

  # programs = {
  #   ssh.startAgent = false;
  #
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true; };
  # };

  # # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  security.pam.u2f = {
    enable       = true;
    settings.cue = true;
    control      = "sufficient";
  };
  
  security.pam.services = {
    greetd.u2fAuth   = true;
    sudo.u2fAuth     = true;
    swaylock.u2fAuth = true;
    # hyprlock.u2fAuth = true;
  };
}
