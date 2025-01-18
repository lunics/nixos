{ pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-touch-detector
    yubikey-agent                     # ssh-agent for yubikey
    # yubikey-full-disk-encryption    # doesn't exist
    yubico-pam
    # pam-u2f           ## not available
    age-plugin-yubikey
    age
    # rage      # age in rust
    pcsclite
  ];

  services.pcscd.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.yubikey-agent.enable = true;   # install the service in user space
    # Every session requires the PIN, every login requires a touch. Setup takes care of PUK and management key

  # programs = {
  #   ssh.startAgent = false;
  #
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true; };
  # };

  # # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  # src
  #   https://developers.yubico.com/pam-u2f/
  #   https://developers.yubico.com/pam-u2f/Manuals/pam_u2f.8.html
  security.pam.u2f = {
    enable       = true;
    # settings = {
    #   appid       = "pam://$HOSTNAME";
    #   origin      = "pam://$HOSTNAME"; 
    #   authfile    = "$HOME/.config/Yubico/u2f_keys";
    #   cue         = true;       # display a reminder message to touch the Yubikey
    #   debug       = false;
    #   interactive = true;       # prompt a message and wait before testing the presence of a U2F device, recommended if your device doesn’t have a tactile trigger
    # };
    # settings = {
    #   authfile = "/etc/u2f_keys";
    #   authpending_file = "";
    #   pinverification = 1;
    #   userpresence = 0;
    # }
    control      = "sufficient";      # "required", "requisite", "sufficient", "optional"
  };
  
  security.pam.services = {
    greetd.u2fAuth   = true;
    sudo.u2fAuth     = true;
    swaylock.u2fAuth = true;
    # hyprlock.u2fAuth = true;
  };
}
