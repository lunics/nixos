{
  programs.zsh.zplug.plugins = [
    { name = "marlonrichert/zsh-autocomplete"; }
  ];

  programs.zsh.initContent = ''
    setopt AUTO_LIST         # Liste auto quand il y a plusieurs choix
    setopt AUTO_MENU         # Passe automatiquement en menu select
    setopt COMPLETE_IN_WORD  # Complète au milieu d'un mot

    # Active l’inline suggestion à la fish (déjà on par défaut, mais explicitons)
    zstyle ':autocomplete:*' widget-style menu  # menu + inline suggestions
    
    # Affichage de la liste
    zstyle ':autocomplete:list-choices:*' max-lines 20
    
    # Tri intelligent
    zstyle ':autocomplete:*' group-order \
      'commands' 'builtins' 'aliases' 'functions' \
      'parameters' 'paths' 'files' 'history'
    
    # Delay minimal pour les suggestions
    zstyle ':autocomplete:*' min-delay 0.03
    
    # Désactive le preview de fichier (parfois lent)
    zstyle ':autocomplete:list-*' insert-preview false
    
    # Résultats de complétion en arrière-plan (défaut = true)
    zstyle ':autocomplete:*' async true
    
    # Plus fluide sur terminaux modernes
    zstyle ':autocomplete:*' add-space false
    
    ### --- Compatibilité ++ avec autosuggestions ---
    # Donne priorité à l'autocomplete pour éviter les conflits d'inline preview
    ZSH_AUTOSUGGEST_STRATEGY=('history')
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  '';
}
