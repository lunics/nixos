{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    main-home.includes = with aspects; [
      ai
      browser
      # client_mail
      desktop
      devops
      # editor
      neovim
      file_explorer
      gaming
      git
      media
      messaging
      # misc
        # gpg
        home
        ssh_client
        stylix
      multiplexer
      music
      nix
      home
      packages
      pass_manager
      user-services
      shell
      task_manager
      terminal
      torrent
      xdg
    ];
  };
}
