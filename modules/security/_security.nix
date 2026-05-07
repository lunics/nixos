{
  flake.aspects.security.nixos = { pkgs, ... }:{
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;

    security.pam.services.hyprlock   = {};
    security.pam.services.swaylock.text = ''
      auth    sufficient   pam_u2f.so      nouserok origin=pam://laptop-t14 appid=pam://laptop-t14 authfile=/etc/yubico/u2f_keys cue
      auth    include login
    '';

    security.polkit.enable = true;

    programs.browserpass.enable = true;

    environment.systemPackages = with pkgs; [
      # vulnix     # scan: vulnix --system
      # clamav     # scan: sudo freshclam; clamscan [options] [file/directory/-]
      # chkrootkit # scan: sudo chkrootkit
      pass-wayland
      # pass2csv
      passExtensions.pass-tomb
      passExtensions.pass-update
      passExtensions.pass-otp
      passExtensions.pass-import
      passExtensions.pass-audit
      tomb
    ];
  };
}
