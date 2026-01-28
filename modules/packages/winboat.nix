{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.winboat  {
    home.packages = with pkgs; [
      winboat
      # (unstable.winboat.override {nodejs_24 = pkgs.nodejs_24;})
      freerdp
    ];
  };
}
