{ pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-touch-detector
    yubikey-agent                     # ssh-agent for yubikey
    # yubikey-full-disk-encryption    # doesn't exist
    yubico-pam
    age-plugin-yubikey
    age
    passage
    pcsclite
  ];

  services.pcscd.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  # programs = {
  #   ssh.startAgent = false;
  #
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true; };
  # };

  # # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  # security.pam.u2f = {
  #   enable       = true;
  #   settings.cue = true;
  #   control      = "sufficient";
  # };
  #
  # security.pam.services = {
  #   greetd.u2fAuth   = true;
  #   sudo.u2fAuth     = true;
  #   hyprlock.u2fAuth = true;
  # };
}
