{ config, pkgs, inputs, ... }:{ programs.zsh = {

enable   = true;
package  = pkgs.zsh;
enableCompletion = false;
autosuggestion.enable = true;
syntaxHighlighting.enable = true;

# OK for single file
# initExtra = builtins.readFile ../files/zsh/functions/zoxide.zsh;

# OK for multiple files
initExtra = ''
  ${builtins.readFile ../files/zsh/functions/zoxide.zsh    }
  ${builtins.readFile ../files/zsh/functions/open_yazi.zsh }
'';

# initExtra = ''
#   # source ~/.config/shell/zsh/functions/open_yazi.zsh
#   # source ~/.config/shell/zsh/functions/zoxide.zsh
#   source ${relativeSymlink configDirectory ../files/zsh/functions/zoxide.zsh}
# '';
# initExtra = xdg.configFile."zsh/zshrc"; # KO
# initExtra = "${config.home.sessionVariables.XDG_CONFIG_HOME}/zsh/zshrc";

# zplug = {
#   enable = true;
#   plugins = [
#     # { name = "zsh-users/zsh-autosuggestions";   }
#     # { name = "marlonrichert/zsh-autocomplete";  }
#     # { name = "zdharma-continuum/fast-syntax-highlighting"; }
#     # { name = "olets/zsh-abbr"; tags = ["at:82fc2b53d7b1c2df60fdea6f13701cff9c536197"]; }
#   ];
# };

}; }
