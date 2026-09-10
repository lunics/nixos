{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    all.includes = with aspects; [
      # generic
      options

      # nixos
      disk
      boot
      nix
      hardware
      facter
      kernel
      etc
      network
      desktop_nixos
      desktop-nixos
      audio
      steam
      graphic
      location
      ntp
      programs
      udev
      wsl
      security
      services
      ssh
      virtualisation
      secrets
      tailscale
      mullvad
      facter

      # home manager
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
      messaging
      # misc
      # gpg
      home
      # ssh
      stylix
      # multiplexer
        tmux
        herdr
        screen
        zellij
      music
      nix
      packages
      pass_manager
      secrets
      shell
      task_manager
      terminal
      torrent
      # services
      xdg
      bluetooth
      librepods
      ableton
      pomodoro
      lutris
      zmk
    ];
  };
}
