{ pkgs, ... }:{
  # { config, ... }
  
  home.packages = with pkgs; [
    yubikey-touch-detector
  
    # age-plugin-yubikey
    # age
    # passage
    # pcsclite
  ];
  
  # https://github.com/maximbaz/yubikey-touch-detector
  services.yubikey-touch-detector.enable = true;
  # $ systemctl --user daemon-reload
  # $ systemctl --user enable --now yubikey-touch-detector.service
  
  # home.sessionVariables = rec {
  #   PASSAGE_DIR             = "$HOME/.local/share/passage/store";
  #   PASSAGE_IDENTITIES_FILE = "$HOME/.local/share/passage/identities";
  #   PASSAGE_AGE             = "rage";     # age or rage
  #   PASSAGE_RECIPIENTS_FILE = "$HOME/.local/share/passage/store/.age-recipients";
  #   PASSAGE_RECIPIENTS      = "";
  # };

}
