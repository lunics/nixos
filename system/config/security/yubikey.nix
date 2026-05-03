{ pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-touch-detector
    yubikey-agent                     # ssh-agent for yubikey
    # yubikey-full-disk-encryption    # doesn't exist
    yubico-pam
    pam_u2f
    age-plugin-yubikey
    age
    # rage      # age in rust
    pcsclite
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
 
  security.pam = {
    # # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
    # src
    #   https://developers.yubico.com/pam-u2f/
    #   https://developers.yubico.com/pam-u2f/Manuals/pam_u2f.8.html
    u2f = {
      # auth sufficient                                                                        pam_u2f.so      nouserok origin=pam://laptop-t14 appid=pam://laptop-t14 authfile=/etc/yubico/u2f_keys                                              cue [cue_prompt=Please touch the yubikey...]
      # auth sufficient /nix/store/92zzyannh3rfz2p02335wlldrvgngpdz-pam_u2f-1.3.1/lib/security/pam_u2f.so                                                              authfile=/nix/store/1mfa91zk6cmvn8zbc6ajhz2inrw8hhn9-source/files/u2f_keys cue interactive # u2f (order 10900)

      enable  = true;
      control = "sufficient";       # "required", "requisite", "sufficient", "optional"
      settings = {
        authfile    = builtins.toString ../files/u2f_keys;
        cue         = true;       # display a reminder message to touch the Yubikey
        interactive = true;       # prompt a message and wait before testing the presence of a U2F device, recommended if your device doesn’t have a tactile trigger
        debug       = false;
        appid       = "pam://$HOSTNAME";
        origin      = "pam://$HOSTNAME"; 
        # authpending_file = "";
        # pinverification = 1;
        userpresence = 1;
      };
    };
    services = {
      # login.u2fAuth    = true;
      greetd.u2fAuth   = true;
      sudo.u2fAuth     = true;
      swaylock.u2fAuth = true;
      # hyprlock.u2fAuth = true;
    };
  };
}
