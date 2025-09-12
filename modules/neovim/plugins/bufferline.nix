{
  plugins = {
    bufferline.enable   = true;
    web-devicons.enable = true; };

  extraConfigLua = ''
    require('bufferline').setup {
      options = {
        mode                 = "buffers",                    -- buffers, tabs=only show tabpages instead
        numbers              = "none",
        indicator            = { style = 'none' },
        separator_style      = { "" },
        tab_size             = 0,
        buffer_close_icon    = "",
        modified_icon        = "*",
        close_icon           = "",
        left_mouse_command   = "buffer %d",
        right_mouse_command  = false,
        middle_mouse_command = "bdelete! %d",
        truncate_names       = true,      -- false=show entire file name
        max_name_length      = 15,
        -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size                = 10,
        separator_style         = "thin",   -- "slope", "thick", "thin", { 'any', 'any' }
        enforce_regular_tabs    = false,
        always_show_bufferline  = true,
        offsets = {
          {
            filetype    = "NvimTree",
            text        = "File Explorer",
            text_align  = "left",           -- | "center" | "right"
            separator   = false,
          }
        },
      },
      highlights = {
        buffer_selected = {
          -- fg      = "#7a7c9e", -- normal_fg,
          ctermfg = 2,                -- When `termguicolors` is not enabled use this syntax
          bold    = true,
          italic  = false,
        },
      }
    }
  '';
}
