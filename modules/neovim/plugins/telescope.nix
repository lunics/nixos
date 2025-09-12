{
  # https://github.com/nvim-telescope/telescope.nvim/

  ## https://github.com/nix-community/nixvim/tree/main/plugins/by-name/telescope/extensions
  ## https://github.com/nvim-telescope/telescope-media-files.nvim
  ## https://github.com/nvim-telescope/telescope-file-browser.nvim
  ## https://github.com/debugloop/telescope-undo.nvim

  plugins.telescope = {
    enable = true;
    extensions = {
      file-browser.enable = true;
      frecency.enable     = true;
      fzf-native.enable   = true;
      manix.enable        = true;
      media-files.enable  = true;
      ui-select.enable    = true;
      undo.enable         = true;
    };
  };

  # Optional dependencies
  # sharkdp/fd (finder)
  # nvim-treesitter/nvim-treesitter (finder/preview)
  # neovim LSP (picker)
  # devicons (icons

  extraConfigLua = ''
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f',  builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep'  })
    vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers'    })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags'  })

    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
      -- KO ["<M-p>"] = action_layout.toggle_preview

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,   -- esc for direct exiting finder
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = false,           -- clear prompt
          },
          n = {
          },
        },
        sorting_strategy = "ascending";
        previewer = true,
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top";
        };
        selection_caret = "> ";
        set_env = {
          COLORTERM = "truecolor";
        };
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "%.ipynb"
        ];
      },
      pickers = {
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- ignore_case, respect_case, smart_case
        }
      }
    }
    require('telescope').load_extension('fzf')
  '';
}
