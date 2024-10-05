{ pkgs, ... }:{

programs.librewolf = {
  enable  = true;
  package = pkgs.librewolf;
  # settings = {
  #   "webgl.disabled" = false;
  #   "privacy.resistFingerprinting" = false;
  # };
};

}
