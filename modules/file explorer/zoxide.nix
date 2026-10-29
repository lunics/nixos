{
  flake.aspects.file_explorer.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      zoxide
    ];

    _.persistent-home.dirs = [ ".local/share/zoxide" ];    # default _ZO_DATA_DIR
  };
}
