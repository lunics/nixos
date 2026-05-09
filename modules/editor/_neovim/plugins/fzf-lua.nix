{
  # https://github.com/ibhagwan/fzf-lua/
  # https://github.com/ibhagwan/fzf-lua/blob/main/OPTIONS.md
  # https://github.com/kazhala/dotfiles/blob/master/.config/nvim/lua/kaz/plugins/fzf-lua.lua

  ## require plugin nvim-web-devicons
  # Optional dependencies
  #   fd - better find utility
  #   rg - better grep utility
  #   bat - syntax highlighted previews when using fzf's native previewer
  #   delta - syntax highlighted git pager for git status previews
  #   nvim-dap - for Debug Adapter Protocol (DAP) support


  plugins.fzf-lua.enable = true;

  extraConfigLua = ''
    local map = vim.keymap.set
    local fzflua = require("fzf-lua")

    map("n", "<Leader><Leader>", fzflua.files)
    map("n", "'",                fzflua.files)
    map("n", "\"",               fzflua.buffers)
    map("n", "<Leader>h",        fzflua.live_grep_resume)
    map("n", "<Leader>sh",       fzflua.help_tags)
    map("n", "<Leader>sm",       fzflua.keymaps)
    map("n", "<Leader>sl",       fzflua.highlights)

    require('fzf-lua').setup {
      files = {
        cwd           = "~/",
        resume        = false,      -- true = from where you left off
        previewer     = "bat",      -- builtin, bat, false
        prompt        = " ",
        multiprocess  = true,       -- run command in a separate process
        path_shorten  = 25,         -- true = shortened using a built-in algorithm, custom number = if a path is shorter than n characters, it will not be shortened
        file_icons    = false;
      },
      winopts = {
        fullscreen  = false,
        height      = 0.6,
        width       = 0.93,
        row         = 0.99,    -- 1 = from the bottom, 0.3 = start the fzf window at 30% of the total window height
        preview = {
          layout      = "horizontal",
          title       = false,
          delay       = 0,
          scrollbar   = false,
          hidden      = "nohidden",   -- hidden = Display hidden files
          scrollchars = { "▎", "" },
        },
      },
      previewers = {
        builtin = {
          scrollbar = false,
        },
        bat = {
          cmd             = "bat",
          args            = "--style=numbers,changes --color always",
          scrollbar = false,
          -- theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
          -- config          = nil,            -- nil uses $BAT_CONFIG_PATH
        },
      },
    }
  '';

    # local actions = require('fzf-lua.actions')
    # require('fzf-lua').setup({
    #   files = {
    #     fzf_opts = {
    #       -- ['--border'] = 'none',
    #     },
    #   }
    #   winopts = {
    #     hl = {
    #       border = 'FloatBorder',
    #     },
    #   },
    #   preview_layout = 'flex',
    #   flip_columns = 150,
    #   grep = {
    #     actions = {
    #       ['default'] = actions.file_edit_or_qf,
    #       ['ctrl-q']  = actions.file_sel_to_qf,
    #     },
    #   },
    #   buffers = {
    #     git_icons = false,
    #     actions = {
    #       ['ctrl-w'] = actions.buf_del,
    #       ['ctrl-q'] = actions.file_sel_to_qf,
    #     },
    #   },
    #   files = {
    #     fd_opts = [[--color never --type f --hidden --follow --strip-cwd-prefix]],
    #     git_icons = false,
    #     actions = {
    #       ['default'] = actions.file_edit,
    #       ['ctrl-q'] = actions.file_sel_to_qf,
    #     },
    #   },
    #   quickfix = {
    #     git_icons = false,
    #     actions = {
    #       ['default'] = actions.file_edit_or_qf,
    #       ['ctrl-q'] = actions.file_sel_to_qf,
    #     },
    #   },
    # })
    #
}
