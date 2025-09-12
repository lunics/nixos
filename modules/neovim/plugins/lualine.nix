{
  # https://github.com/nvim-lualine/lualine.nvim 6K *

  plugins.lualine.enable = true;

  extraConfigLua = ''
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox',      -- auto, tokyonight, gruvbox
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          -- tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        -- lualine_a = {'mode'},
        lualine_a = { { 'filename', path = 2 } },
        lualine_b = { 'branch' },             -- 'branch', 'diff', 'diagnostics'
        lualine_c = {},
        lualine_x = {
          function()
            return require('auto-session.lib').current_session_name(true)
          end
        },
        -- lualine_x = {},             -- {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {}              -- {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = nil,
      -- {
      --   lualine_a = {},   -- "buffers"
      --   lualine_b = {},
      --   lualine_c = {},
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  '';
}
