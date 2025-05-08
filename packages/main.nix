{ pkgs, inputs, ... }:{ 
  home.packages = with pkgs; [
    inputs.flake-neovim.packages."${system}".default
    lazygit
    yazi
    ueberzugpp
    python3
    tomb
    sshfs
    go-task           # taskfile
    wl-clipboard
    # clipboard-jh    # best wayland clipboard
    
    ansible
    sshpass           # required by ansible for remote connections
    
    # thefuck
    # pay-respects      # thefuck replacement written in Rust
    
    comma             # to run nix pkgs without installing them
    
    # devbox        ## Need Root permissions to be installed
    
    lsd
    eza
    fzf
    zoxide
    bat
    ripgrep
    entr            # permet de run des script automatiquement dans shell lorsque fichier source est modifier: ls *.rb | entr ruby main.rb wget
    fd
    trash-cli
    
    udiskie
    
    bottom
    pciutils          # for lspci
    usbutils          # for lsusb
    
    comma             # to runs nix software without installing it
    nix-search-cli    # CLI for searching packages on search.nixos.org
    
    # archive
    ouch
    xarchiver
    
    # HYPRLAND
    # qt5   KO
    # qt6   KO
    
    # screensharing
    grim
    jq
    slurp
    # HYPRLAND
    
    # media controls
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv
    
    bibata-cursors    # Open source, compact, and material designed cursor set
    
    # Used by scripts
    pwgen
    # coreutils   # to get: shuf
    
    sqlite
    psmisc        # to get: fuser (to unlock sqlite db)
    
    localsend
    chatblade

    android-file-transfer
    zmkBATx       # Battery monitoring for ZMK split keyboards
  ];
}
