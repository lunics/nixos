{ lib, ... }: with lib; {
  imports = [
    ./ssh.nix
    ./desktop.nix
    ./tmux.nix
  ];

  options._ = {
    username = mkOption {
      type    = types.str;
      default = "nixos";
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

