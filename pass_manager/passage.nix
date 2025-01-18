{ pkgs, config, ... }:{

  home = {
    packages = with pkgs; [
      passage
      # age     # installed from system
      # rage    # //
    ];

    sessionVariables = rec {
      PASSAGE_DIR             = "$HOME/.local/share/passage/store";
      PASSAGE_IDENTITIES_FILE = "$HOME/.config/age/identities";
      # PASSAGE_AGE             = "";   # IF rage
    };

    file.".config/age/identities".source = ../files/age_identities;
  };
}
