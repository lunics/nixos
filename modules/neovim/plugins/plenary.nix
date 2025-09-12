{ pkgs, ...}: {
  # All the lua functions I don't want to write twice

  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
  ];
}
