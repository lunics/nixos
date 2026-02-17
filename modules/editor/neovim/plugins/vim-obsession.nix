{ pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-obsession
  ];
}
