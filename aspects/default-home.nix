{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    default-home.includes = with aspects; [
      ai
      browser
      desktop
      neovim
      file_explorer
      git
      media
      messaging
      # misc
        home
        ssh_client
        stylix
      multiplexer
      nix
      packages
      pass_manager
      secrets
      shell
      task_manager
      terminal
      services
      xdg
      bluetooth
    ];
  };
}
