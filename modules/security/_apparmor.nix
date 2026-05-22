{
  flake.aspects.apparmor.nixos = { pkgs, ... }:{
    security.apparmor = {
      enable   = true;
      packages = with pkgs; [ 
        apparmor-utils 
        apparmor-profiles
      ];
    };
  };
}
