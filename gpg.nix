{ pkgs, config, ... }:{
programs.gpg = { enable  = true;
  package = pkgs.gnupg;
  settings = {
    no-default-keyring  = true;
    keyring             = "keyring-path";
    keyid-format        = "short";          # short, 0xlong
    charset             = "utf-8";
    fixed-list-mode     = true;
    no-comments         = true;
    no-emit-version     = true;
    list-options        = "show-uid-validity";
    verify-options      = "show-uid-validity";
    with-fingerprint    = true;
    # with-keygrip
    no-symkey-cache     = true;
    use-agent           = true;
    require-cross-certification = true;
  };

  # no need to define: GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
  homedir = "${config.xdg.dataHome}/gnupg";

  publicKeys = [];
};

services.gpg-agent.enable = true;

# agent = {
#   enable = true;
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


# services.yubikey-agent.enable

}
