{ pkgs, config, ... }:{
  programs.password-store = {
    enable   = true;
  
    package  = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
      exts.pass-tomb
      exts.pass-update
      exts.pass-import
      exts.pass-audit
    ]);
  
    settings = {
      PASSWORD_STORE_GPG_OPTS = "--homedir ${config._.share}/gnupg";
      PASSWORD_STORE_DIR      = "${config._.share}/password-store";
      # PASSWORD_STORE_KEY       = "12345678";
      # PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
  
  programs.browserpass.enable = true;
  
  # environment.systemPackages = with pkgs; [
  #   tomb
  #   pass2csv
  #   pass-wayland
  #   # passphrase2pgp
  # ];
  
  # home.packages = with pkgs; [
  #   pinentry-curses
  #     # Pinentry doesn't work on WSL NixOS unless manually configured on gpg-agent.conf
  #     # See https://sigkill.dk/writings/guides/nixos_pass.html
  # ];
}
