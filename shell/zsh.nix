{ config, pkgs, ... }:{ programs.zsh = {

enable   = true;
package  = pkgs.zsh;
enableCompletion = false;
autosuggestion.enable = true;
syntaxHighlighting.enable = true;
# initExtra = builtins.readFile ./zshrc;
# initExtra = xdg.configFile."zsh/zshrc"; # KO
# initExtra = "${config.home.sessionVariables.XDG_CONFIG_HOME}/zsh/zshrc";

zplug = {
  enable = true;
  plugins = [
    { name = "zsh-users/zsh-autosuggestions";   }
    { name = "marlonrichert/zsh-autocomplete";  }
    { name = "zdharma-continuum/fast-syntax-highlighting"; }
    { name = "olets/zsh-abbr"; tags = ["at:82fc2b53d7b1c2df60fdea6f13701cff9c536197"]; }
  ];
};

}; }
