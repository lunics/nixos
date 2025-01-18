{ pkgs, config, ... }:{

  home = {
    packages = with pkgs; [
      passage
      age
      # rage
    ];

    sessionVariables = rec {
      PASSAGE_DIR             = "$XDG_DATA_HOME/passage/store";
      PASSAGE_IDENTITIES_FILE = "$XDG_CONFIG_HOME/age/identities";
      # PASSAGE_AGE             = "";   # IF rage
    };

    file.".config/age/identities".source = ../files/age_identities;
  };
}
