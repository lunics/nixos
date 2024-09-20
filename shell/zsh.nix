{ config, pkgs, inputs, ... }:{ programs.zsh = {

enable   = true;
package  = pkgs.zsh;
enableCompletion = false;
autosuggestion.enable = true;
syntaxHighlighting.enable = true;

# let
#   createAndReadFile = text: builtins.readFile (builtins.toFile "myFile" text);
# in
#   createAndReadFile "Hello, World!"
# initExtra = builtins.readFile ./source_zshrc;
initExtra = ''
  unsetopt PROMPT_SP                  # remove % on the user prompt and # on the root prompt
  setopt auto_pushd                   # ??
  setopt pushd_ignore_dups            # ??
  setopt pushdminus                   # ??
  setopt interactive_comments         # enable commentary in cli
  setopt autocd                       # enable cd into typed directory
  setopt completealiases              # enable alias tab completion

  _open_yazi() {
    if [[ $#BUFFER == 0 ]]; then
      yazi < $TTY
      # KO
      # LASTDIR=$(cat /tmp/yazi_save_dir)
      # cd "$LASTDIR"
      zle reset-prompt
    else
      zle expand-or-complete
    fi
  }
  zle -N _open_yazi
  bindkey '^I' _open_yazi     # IF tab pressed when prompt is empty THEN run yazi
'';
  # source ${relativeSymlink configDirectory ./dotfiles/functions.zsh}

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
