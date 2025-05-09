{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    slack
    telegram-desktop
    # materialgram
    element-desktop
    ferdium               # franz app like but free
    whatsie
    nchat                 # Terminal-based chat client with support for Telegram and WhatsApp
    # altus               # client for WhatsApp Web with themes, notifications and multiple account support 
    # wasistlos
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
  ];
}
