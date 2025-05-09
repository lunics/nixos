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
    
    udiskie
    
    bottom
    pciutils      # for lspci
    usbutils      # for lsusb
    zmkBATx       # battery monitoring for ZMK split keyboards
    dysk          # information on the mounted disks
    
    comma             # to runs nix software without installing it
    
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

    sqlite
    psmisc        # to get: fuser (to unlock sqlite db)

    localsend
    chatblade

    android-file-transfer
  ];
}
