{ config, lib, ... }: with lib; {
  imports = [
    ./ssh.nix
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
  };
}

