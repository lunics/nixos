{ config, lib, ... }: with lib; {
  imports = [
    ./ssh.nix
    ./tmux.nix
    ./yazi.nix
    ./neovim.nix
    ./desktop.nix
    ./hyprland.nix
  ];

  options._ = {
    username = mkOption {
      type    = types.str;
      default = "nixos";
    };

    share = mkOption {
      type    = types.str;
      default = config.xdg.dataHome;
    };

    terminal = mkOption {
      type    = types.str;
      default = "ghostty";
    };

    browser = mkOption {
      type    = types.str;
      default = "zen";
    };

    openai_api_key = mkOption {
      type    = types.str;
      default = "";
    };

    splitkb = mkOption {
      type    = types.bool;
      default = false;
    };
  };
}
