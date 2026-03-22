{
  # https://github.com/folke/snacks.nvim/
  # required by opencode

  plugins.snacks.enable = true;

  extraConfigLua = ''
    require("snacks").setup {
      opts = {
        -- REQUIRED BY OPENCODE
        input  = { enabled = true },    -- Enhances ask()
        picker = {                      -- Enhances select()
          enabled = true,
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
        -- END REQUIRED BY OPENCODE

        animate      = { enabled = false },
        dim          = { enabled = false },
        bigfile      = { enabled = false },
        dashboard    = { enabled = false },
        explorer     = { enabled = false },
        gh           = { enabled = false },
        gitbrowse    = { enabled = false },
        indent       = { enabled = false },
        image        = { enabled = false },
        layout       = { enabled = false },
        lazygit      = { enabled = false },
        notifier     = { enabled = false },
        profiler     = { enabled = false },
        quickfile    = { enabled = false },
        scope        = { enabled = false },
        scroll       = { enabled = false },
        scratch      = { enabled = false },
        statuscolumn = { enabled = false },
        styles       = { enabled = false },
        terminal     = { enabled = false },
        toggle       = { enabled = false },
        win          = { enabled = false },
        words        = { enabled = false },
        zen          = { enabled = false },
      },
    }
  '';
}
