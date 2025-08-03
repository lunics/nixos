{ config, lib, ... }: with lib; {
  # imports = [
  # ];

  options._ = {
    username = mkOption {
      type    = types.str;
      default = "nixos";
    };
  };
}

