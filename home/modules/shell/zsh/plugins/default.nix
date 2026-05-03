{ config, pkgs, ... }:{ 
  imports = [
    # ./autocomplete.nix KO
    ./fzf-tab.nix
  ];

  programs.zsh.zplug = {
    enable    = true;
    zplugHome = "${config.programs.zsh.dotDir}/zplug";
    package   = pkgs.zplug;
    plugins = [
      { name = "hlissner/zsh-autopair";              } # auto-add closing brackets, quotes, etc.
      # { name = "jeffreytse/zsh-vi-mode";             } # Better than built‑in bindkey -v
      # { name = "MichaelAquilina/zsh-you-should-use"; }
      # { name = "changyuheng/zsh-interactive-cd";     }
    ];
  };
}
