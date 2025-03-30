{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    slack
    telegram-desktop
    element-desktop
    ferdium               # franz app like but free
    
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
