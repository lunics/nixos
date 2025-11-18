{ pkgs, inputs, ... }:{ 
  home.packages = with pkgs; [
    systemd
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

    # archive
    ouch
    xarchiver

    # qt5   KO
    # qt6   KO
    
    jq

    joplin
    
    bibata-cursors    # Open source, compact, and material designed cursor set

    sqlite
    psmisc        # to get: fuser (to unlock sqlite db)
    httpie        # curl/wget replacement
    # http-prompt   # httpie interactive KO ERROR: file 'src/prompt_toolkit/__init__.py' does not exist

    chatblade
    # varia

    qrencode      # generate QR code from client conf
    numbat        # bc replacement
    jqp
    bluetui       # tui bluetooth manager
    wipe
    entr          # run arbitrary commands when files change
    libreoffice

    tigervnc
  ];
}
