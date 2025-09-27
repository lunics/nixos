{ pkgs, ... }:{
  programs.yazi = {
    enable  = true;
    package = pkgs.yazi;
    enableZshIntegration = true;

    # available plugins: https://github.com/NixOS/nixpkgs/tree/master/pkgs/by-name/ya/yazi/plugins
    plugins = {
      inherit (pkgs.yaziPlugins) smart-enter;
      inherit (pkgs.yaziPlugins) rich-preview;
      inherit (pkgs.yaziPlugins) restore;
      inherit (pkgs.yaziPlugins) duckdb;
      inherit (pkgs.yaziPlugins) full-border;
      inherit (pkgs.yaziPlugins) no-status;
      inherit (pkgs.yaziPlugins) wl-clipboard;
      inherit (pkgs.yaziPlugins) yatline;
      inherit (pkgs.yaziPlugins) time-travel;
      inherit (pkgs.yaziPlugins) smart-paste;       # Paste files into the hovered directory
      inherit (pkgs.yaziPlugins) smart-filter;
      inherit (pkgs.yaziPlugins) ouch;              # to preview and extract archives
      inherit (pkgs.yaziPlugins) mediainfo;         # previewing media files
      inherit (pkgs.yaziPlugins) chmod;
      # fzf         = ./plugins/fzf.yazi;
    };
    # flavors = {       # Pre-made themes: https://yazi-rs.github.io/docs/flavors/overview/
    #   foo = ./foo;
    #   inherit (pkgs.yaziPlugins) bar;
    # }
    initLua = ./init.lua;
  };

  imports = [
    ./yazi.nix
    ./keymap.nix
    # ./theme.nix
  ];
  
  home.packages = with pkgs; [
    ueberzugpp    # required for image preview (in tmux ?)
  ];

  # to enable yazi's image preview to work correctly in tmux
  programs.tmux.extraConfig = ''
    set -g allow-passthrough on
    set -ga update-environment TERM
    set -ga update-environment TERM_PROGRAM
  '';
}
