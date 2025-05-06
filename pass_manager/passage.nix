{ pkgs, config, ... }:{
  home = {
    packages = with pkgs; [
      passage
      oath-toolkit      # as a pass-otp replacement
      # age     # installed from system
      # rage    # //
    ];

    sessionVariables = rec {
      PASSWORD_STORE_DIR      = "$HOME/usb_copy/homelab/share/passage/store";   # for rofi-pass
      PASSAGE_DIR             = "$HOME/usb_copy/homelab/share/passage/store";
      PASSAGE_IDENTITIES_FILE = "$HOME/.config/age/identities";
      # PASSAGE_AGE             = "";   # IF rage
      PASSWORD_STORE_CLIP_TIME = "20";
    };

    file.".config/age/identities".source = ../files/age_identities;
  };
}
