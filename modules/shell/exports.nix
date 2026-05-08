{ config, ... }:{ 
  # home.sessionVariables = rec {
  programs.zsh.sessionVariables = rec {
    EDITOR          = config._.editor;
    MANPAGER        = "nvim +Man!";
    READER          = "zathura";
    CONFIG          = config._.dot_config;
    LOCAL           = "$HOME/.local";
    CACHE           = config._.dot_cache;
    BIN             = "$HOME/.local/bin";
    SSH             = "$HOME/.config/ssh";
    SHARE           = config._.local_share;
    CLOUD           = "$HOME/usb_copy";
    USB             = "/run/media/$USER";
    DOWNLOADS       = "~/downloads";
    LINUX           = "$CLOUD/linux";
    HOMELAB         = "$CLOUD/homelab";
    KUBERNETES      = "$LINUX/kubernetes";
  };
}
