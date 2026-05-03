{
  # https://github.com/xiyaowong/transparent.nvim

  plugins.transparent.enable = true;

  ## needs :TransparentEnable

  extraConfigLua = ''
    require('transparent').clear_prefix('BufferLine')
    require('transparent').clear_prefix('NeoTree')
    require('transparent').clear_prefix('lualine')
  '';
}
