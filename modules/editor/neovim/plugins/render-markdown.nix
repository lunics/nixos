{
  # https://github.com/MeanderingProgrammer/render-markdown.nvim

  plugins.render-markdown.enable = true;

  extraConfigLua = ''
    require('render-markdown').setup {
      heading = {
        enabled          = true,
        position         = 'inline',    -- display icon at the begining of # instead at the end
        atx              = true,
        setext           = true,
        sign             = true,
        backgrounds      = {},
      },
      paragraph = {
        enabled          = true,
        indent           = 2,
      },
      code = {
        enabled          = true,
        left_pad         = 2,
        highlight        = "",
        highlight_border = "",
        language_info    = true,
        language_icon    = false,
        language_name    = false,
        language_pad     = 2,
      },
      indent = {
        enabled          = true,
        skip_level       = 1,
        icon             = "",
        per_level        = 1,
      },
      dash = {
        left_margin      = 2,
      },
      bullet = {
        left_pad         = 2,
      },
    }
  '';
}
