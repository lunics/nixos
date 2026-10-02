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
      audio
      steam
      graphic
      location
      ntp
      programs
      wsl
      security
      services
      virtualisation
      secrets
      tailscale
      mullvad

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
      git
      media
      messaging
      # misc
      # gpg
      home
      stylix
      tmux
      herdr
      screen
      zellij
      music
      packages
      pass_manager
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
      claude-code
      opencode

      # security
      pam
      polkit
      ssh
      sshd
      sudo
      yubikey
    ];
  };
}
