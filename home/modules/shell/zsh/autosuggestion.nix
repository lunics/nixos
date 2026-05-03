{
  programs.zsh.autosuggestion  = {
    enable         = true;
    highlight      = "fg=8";
    # extraConfig    = {};
    # async          = true;
    strategy       = [ "history" ];   
      # history           the most recent match from history
      # completion        suggestion based on what tab-completion would suggest
      # match_prev_cmd    like history, but chooses the most recent match whose preceding history item matches the most recently executed command
  };
}
