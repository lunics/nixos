{ pkgs, ... }:{

programs.gnupg = {
  enable  = true;
  package = pkgs.gnupg;
  # dirmngr.enable = true;
  # settings = {
  #   no-default-keyring
  #   keyring keyring-path
  #
  #   keyid-format short
  #
  #   # with-fingerprint
  #   # with-keygrip
  # };

  # agent = {
  #   enable   = true;
  #   settings = {
  #     # allow-preset-passphrase ?
  #     default-cache-ttl = 0;               # always ask for yubikey touch
  #     max-cache-ttl = 0;                   # always ask for yubikey touch
  #
  #     max-cache-ttl-ssh = 60480000;        # keep ssh password key persisten very long time
  #     default-cache-ttl-ssh = 60480000;    # cache ttl for unused keys
  #
  #     # pinentry-program /usr/bin/pinentry-tty    # pinentry, pinentry-curses, pinentry-tty
  #   };
  #   enableExtraSocket   = true;
  #   pinentryFlavor      = "curses";
  #   enableSSHSupport    = true;
  #   enableBrowserSocket = true;
  # };

  # homedir = "${config.home.homeDirectory}/.config/gnupg";
};

# services.yubikey-agent.enable

}
