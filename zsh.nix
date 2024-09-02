{ config, pkgs, lib, ... }:{

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;

    # dotDir = "${config.home.sessionVariables.XDG_CONFIG_HOME}/zsh";
    # history.path = "${config.home.sessionVariables.XDG_DATA_HOME}/zsh/history";
    # initExtra = builtins.readFile ./zshrc;
    # initExtraBeforeCompInit = builtins.readFile ./.initExtraBeforeCompInit;

    # ./aliases.nix

    plugins = [];
    # {
    #   name = "zsh-autocomplete";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "marlonrichert";
    #     repo = "zsh-autocomplete";
    #     rev = "23.07.13";
    #     sha256 = "sha256-0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
    #     # sha256 = lib.fakeSha256;
    #   };
    # }
    # {
    #   name = "zsh-abbr";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "olets";
    #     repo = "zsh-abbr";
    #     rev = "v5.1.0";
    #     sha256 = "sha256-iKL2vn7TmQr78y0Bn02DgNf9DS5jZyh6uK9MzYTFZaA=";
    #     # sha256 = lib.fakeSha256;
    #   };
    # }

  # programs.zsh.zplug = {
  #   enable = false;
  #   plugins = [
  #     # {name = zdharma-continuum/fast-syntax-highlighting";}
  #     {name = "marlonrichert/zsh-autocomplete";}
  #     { name = "olets/zsh-abbr"; # tags = ["at:82fc2b53d7b1c2df60fdea6f13701cff9c536197"]; }
  #   ];
  # };
  };
}
