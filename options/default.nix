{ config, lib, ... }: with lib; {
  imports = [
    ./ssh.nix
    ./tmux.nix
    ./yazi.nix
    ./paths.nix
    ./music.nix
    ./neovim.nix
    ./desktop.nix
    ./hyprland.nix
  ];

  options._ = {
    user = mkOption {
      type    = types.str;
      default = "nixos";
    };

    user_id = mkOption {
      type    = types.int;
      default = 1000;
    };

    editor = mkOption {
      type    = types.str;
      default = "nvim";
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

    github_token = mkOption {
      type    = types.str;
      default = "";
    };

    flake_dir = mkOption {
      type    = types.str;
      default = "";
    };
    
    splitkb   = mkEnableOption "";

    ansible   = mkEnableOption "";

    terraform = mkEnableOption "";

    podman    = mkEnableOption "";

    winboat   = mkEnableOption "";

    devbox    = mkEnableOption "";

    kube      = mkEnableOption "";

    keyring = mkOption {
      type    = types.str;
      default = "";
    };

    external_vpn = mkOption {
      type    = types.str;
      default = "";
    };
  };
}
