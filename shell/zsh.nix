{ config, pkgs, inputs, ... }:{ programs.zsh = {

# todo
#  https://github.com/romkatv/zsh4humans
#  https://github.com/jeffreytse/zsh-vi-mode

enable   = true;
package  = pkgs.zsh;
enableCompletion = false;
autosuggestion.enable = true;
syntaxHighlighting.enable = true;

initContent = ''
  for file in $HOME/.local/functions/*; do
    source $file
  done

  ${builtins.readFile ./bindkeys.zsh }
'';

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
