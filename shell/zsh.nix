{ config, pkgs, inputs, ... }:{ programs.zsh = {

enable   = true;
package  = pkgs.zsh;
enableCompletion = false;
autosuggestion.enable = true;
syntaxHighlighting.enable = true;

# initExtra = builtins.readFile ./source_zshrc;
initExtra = ''
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

  bindkey "^[^?" backward-kill-word       # alt backspace = delete word before
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
