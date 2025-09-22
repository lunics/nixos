{ lib, ... }: with lib; {
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
