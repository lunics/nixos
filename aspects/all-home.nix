{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    all-home.includes = with aspects; [
      ai
      browser
      # client_mail
      desktop
      devops
      # editor
      neovim
      file_explorer
      gaming
      steam
      git
      media
      # messaging
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
      secrets
      shell
      task_manager
      terminal
      torrent
      user-services
      xdg
      bluetooth
    ];
  };
}
