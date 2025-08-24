{ pkgs, ... }:{
  programs.yazi = {
    enable  = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    # settings = {
    #   # yazi   = {};
    #   keymap.mgr.keymap = [
    #     { on = "s"; run = "shell $SHELL"; }
    #   ];
    #   # theme  = {};
    # };
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
      inherit (pkgs.yaziPlugins) ouch;              # to preview archives
      inherit (pkgs.yaziPlugins) mediainfo;         # previewing media files
      inherit (pkgs.yaziPlugins) chmod;
      # fzf         = ./plugins/fzf.yazi;
    };
    # flavors = {       # Pre-made themes: https://yazi-rs.github.io/docs/flavors/overview/
    #   foo = ./foo;
    #   inherit (pkgs.yaziPlugins) bar;
    # }
    # initLua = ./init.lua;
  };

  home.file.".config/yazi/yazi.toml".source   = ./yazi.toml;
  home.file.".config/yazi/keymap.toml".source = ./keymap.toml;
  # home.file.".config/yazi/theme.toml".source  = ./theme.toml;
  
  # to enable yazi's image preview to work correctly in tmux
  # require pkg ueberzugpp
  programs.tmux.extraConfig = ''
    set -g allow-passthrough on
    set -ga update-environment TERM
    set -ga update-environment TERM_PROGRAM
  '';
}
