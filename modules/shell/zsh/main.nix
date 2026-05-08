{ config, ... }:{ 
  programs.zsh = {
    # todo
    #   https://github.com/romkatv/zsh4humans
    #   https://github.com/jeffreytse/zsh-vi-mode
    
    enable               = true;
    dotDir               = "${config._.dot_config}/zsh";
    # package            = pkgs.zsh;
    enableCompletion     = true;
    autocd               = true;    # automatically enter into a directory if typed directly

    completionInit = ''
      autoload -U compinit && compinit

      # Better completion UX
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    '';

    # promptInit = ''
    #   # autoload -U promptinit && promptinit && prompt suse && setopt prompt_sp
    # '';

    dirHashes = {
      dl = "${config._.home}/downloads";
    };
  }; 

  home.file = {
    ".local/functions/zsh" = {
      source     = ./functions;
      recursive  = true; };
  };
}
