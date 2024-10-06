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

services.gpg-agent = {
  enable              = true;
  defaultCacheTtl     = 0;          # 0 = always ask for yubikey touch
  maxCacheTtl         = 0;          # 0 = always ask for yubikey touch
  defaultCacheTtlSsh  = 60480000;   # 60480000 = cache ttl for unused keys
  maxCacheTtlSsh      = 60480000;   # 60480000 = keep ssh password key persisten very long time
  # enableSshSupport    = true;
  # sshKeys             = "";         # Which GPG keys (by keygrip) to expose as SSH keys
  verbose             = false;
  grabKeyboardAndMouse = true;      # used to avoid X-sniffing attacks
  enableScDaemon      = true;       # to enable smartcard
  extraConfig = ''
  '';
  enableExtraSocket   = false;      # true = GPG Agent forwarding
  enableZshIntegration = true;
  pinentryPackage     = null;       # pinentry, pinentry-curses, pinentry-tty
  # pinentryFlavor      = "curses";
};

# services.yubikey-agent.enable

}
