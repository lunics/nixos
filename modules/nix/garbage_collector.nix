{
  flake.aspects.nix-nixos.nixos = {
    nix.gc = {
      automatic          = true;
      dates              = [ "weekly" ];
      persistent         = true;
      options            = "--delete-older-than 30d";
      randomizedDelaySec = "0";
    };
  };
}
