{ pkgs, ... }:{

programs.password-store = {
  enable   = true;
  package  = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  settings = {
    PASSWORD_STORE_GPG_OPTS = "--homedir ~/.gnupg";
    # $PASSWORD_STORE_DIR   = "${config.home.homeDirectory}/.local/share/password-store";
    PASSWORD_STORE_DIR      = "${config.home.sessionVariables.LOCAL}/share/password-store";  # A TESTER
    # PASSWORD_STORE_KEY       = "12345678";
    # PASSWORD_STORE_CLIP_TIME = "60";
  }; };

  # environment.systemPackages = with pkgs; [
  home.packages = with pkgs; [
    pass
    pinentry-curses
      # Pinentry doesn't work on WSL NixOS unless manually configured on gpg-agent.conf
      # See https://sigkill.dk/writings/guides/nixos_pass.html
  ];
}
