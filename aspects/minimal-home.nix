{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    minimal-home.includes = with aspects; [
      desktop
      file_explorer
      git
      home
      ssh
      nix
      packages
      shell
      task_manager
      terminal
      services
      xdg
    ];
  };
}
