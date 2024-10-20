{ pkgs, ... }:{

programs.wofi = {
  enable   = true;
  package  = pkgs.wofi;
  settings = {
    show          = "drun";
    show_all      = false;
    always_parse_args = true;
    print_command = true;
    insensitive   = true;
    normal_window = true;
    allow_markup  = true;
    prompt        = "Search...";
    width         = "40%";
    height        = "40%";
    key_up        = "Ctrl-k";
    key_down      = "Ctrl-j";
    # location      = "bottom-right";
  };

  # https://cloudninja.pw/docs/wofi.html
  style = builtins.readFile ../files/wofi/style.css;
};

}
