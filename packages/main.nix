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
    termdown
    
    udiskie

    comma             # to runs nix software without installing it

    # archive
    ouch
    xarchiver

    # qt5   KO
    # qt6   KO
    
    jq
    
    # media controls
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv

    joplin
    
    bibata-cursors    # Open source, compact, and material designed cursor set

    sqlite
    psmisc        # to get: fuser (to unlock sqlite db)
    httpie        # curl/wget replacement

    chatblade

    varia
    webtorrent_desktop
    qrencode      # generate QR code from client conf
  ];
}
