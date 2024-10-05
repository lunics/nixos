{ pkgs, config, ... }:{

programs.password-store = {
  enable   = true;
  package  = pkgs.pass.withExtensions (exts: [
    exts.pass-otp
  ]);
  settings = {
    PASSWORD_STORE_GPG_OPTS = "--homedir $XDG_DATA_HOME/gnupg";
    PASSWORD_STORE_DIR      = "${config.xdg.dataHome}/password-store";
    # PASSWORD_STORE_KEY       = "12345678";
    # PASSWORD_STORE_CLIP_TIME = "60";
  };
};

# home.packages = with pkgs; [
#   pinentry-curses
#     # Pinentry doesn't work on WSL NixOS unless manually configured on gpg-agent.conf
#     # See https://sigkill.dk/writings/guides/nixos_pass.html
# ];

}
