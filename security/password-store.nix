{ pkgs, ... }:{

  programs.browserpass.enable = true;

  environment.systemPackages = with pkgs; [
    # passphrase2pgp
    pass-wayland
    pass2csv
    passExtensions.pass-tomb
    passExtensions.pass-update
    passExtensions.pass-otp
    passExtensions.pass-import
    passExtensions.pass-audit
    tomb
  ];
}
