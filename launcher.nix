{ pkgs, ... }:{

programs.wofi = {
  enable   = true;
  package  = pkgs.wofi;
  settings = {
    insensitive   = true;
    normal_window = true;
    prompt        = "Search...";
    width         = "50%";
    height        = "40%";
    key_up        = "Ctrl-k";
    key_down      = "Ctrl-j";
  };
};

}
