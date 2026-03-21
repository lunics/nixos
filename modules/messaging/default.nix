{ pkgs, ... }:{ 
  imports = [
    ./whatsapp.nix
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

    # DISCORD
    discordo              # tui
    discord
    # (discord.override {
    #   # remove any overrides that you don't want
    #   withOpenASAR = true;
    #   withVencord  = true;
    # })
    # betterdiscordctl
    # todo vencord openasar github star
    # # discord-tweaks discord-nord-theme
    # vesktop         # Screensharing with audio on wayland for Discord and others ?

    # MATRIX
    element-desktop
    # matrix-dl         # download backlogs from Matrix as raw text
    # matrix-hook       # webhook for matrix
  ];
}
