{ config, lib, ... }: with lib; {
  imports = [
    ./ssh.nix
    ./tmux.nix
    ./yazi.nix
    ./paths.nix
    ./neovim.nix
    ./desktop.nix
    ./hyprland.nix
  ];

  options._ = {
    user = mkOption {
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

    splitkb = mkEnableOption "";

    home_studio = mkEnableOption "";
  };
}
