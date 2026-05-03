{ pkgs, ... }:{ 
  imports = [
    ./whatsapp.nix
    ./discord.nix
  ];

  home.packages = with pkgs; [
    # SLACK
    slack
    # slackdump           # KO on nixos, only on OS FHS compliant

    # TELEGRAM
    telegram-desktop
    # materialgram

    ferdium               # franz app like but free
    nchat                 # Terminal-based chat client with support for Telegram and WhatsApp

    # MATRIX
    element-desktop
    # matrix-dl         # download backlogs from Matrix as raw text
    # matrix-hook       # webhook for matrix
  ];
}
