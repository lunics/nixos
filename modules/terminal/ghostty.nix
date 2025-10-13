{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.terminal == "ghostty") {
    home.packages = with pkgs; [
      # ghostty         KO build
      # ghostty-bin     KO only on darwin system ?

      # (pkgs.ghostty.overrideAttrs (oldAttrs: rec {
      #   version  = "1.1.3";
      #   src = pkgs.fetchFromGitHub {
      #     owner  = "ghostty-org";
      #     repo   = "ghostty";
      #     rev    = "v${version}";      # tag, branch, or commit
      #     sha256 = "0glwj88s8jj8vrlc42fzwj4v8yzm01szvnl4mg51qaw5wddk4yk0";
      #       # nix-prefetch-url --unpack https://github.com/ghostty-org/ghostty/archive/refs/tags/v1.1.3.tar.gz
      #   };
      # }))

      # (pkgs.ghostty.overrideAttrs (oldAttrs: rec {
      #   version = "1.1.3";
      #   src = pkgs.fetchurl {
      #     url    = "https://github.com/ghostty-org/ghostty/archive/refs/tags/v${version}.tar.gz";
      #     sha256 = "159bdq7chrvdnbjmfy3vgallqxd3nccw1z44zyrzgnbrfvnrdib6";
      #       # nix-prefetch-url https://github.com/ghostty-org/ghostty/archive/refs/tags/v1.1.3.tar.gz
      #         # path is '/nix/store/hb09i92ah2wh8s50kfkrdh1srcvx7b29-v1.1.3.tar.gz'
      #         # 159bdq7chrvdnbjmfy3vgallqxd3nccw1z44zyrzgnbrfvnrdib6
      #   };
      # }))

    ];

    xdg.configFile."ghostty/config".text = ''
      font-family                    = "Ubuntu Mono:style=Regular"
      font-size                      = 23
      background-opacity             = 0.7
      background                     = #1f1f1f
      # background-blur              = 20
      mouse-hide-while-typing        = false
      shell-integration              = zsh
      window-new-tab-position        = current
      focus-follows-mouse            = false
      copy-on-select                 = true
      linux-cgroup                   = always
      desktop-notifications          = true
      keybind                        = alt+c=copy_to_clipboard
      keybind                        = alt+v=paste_from_clipboard
      clipboard-read                 = allow
      clipboard-write                = allow
      clipboard-paste-protection     = true
      clipboard-trim-trailing-spaces = true
      copy-on-select                 = true
      initial-command                = restore_tmux
      working-directory              = home
      auto-update                    = off
      link-url                       = true
    '';
  };
}
