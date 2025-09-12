{
  # https://github.com/max397574/better-escape.nvim

  plugins.better-escape.enable = true;

  extraConfigLua = ''
    local map = vim.keymap.set
    map("i", "jk", "<ESC>")    -- press jk fast to exit insert mode
    map("i", "kj", "<ESC>")    -- press kj fast to exit insert mode
    map("i", "kl", "<ESC>")    -- //
    map("i", "lk", "<ESC>")    -- //

    require("better_escape").setup {
        timeout = vim.o.timeoutlen,
        default_mappings = true,
        mappings = {
            i = {
                j = {
                    k = "<Esc>",
                    j = "<Esc>",
                },
            },
            c = {
                j = {
                    k = "<Esc>",
                    j = "<Esc>",
                },
            },
            t = {
                j = {
                    k = "<C-\\><C-n>",
                },
            },
            v = {
                j = {
                    k = "<Esc>",
                },
            },
            s = {
                j = {
                    k = "<Esc>",
                },
            },
        },
    }
  '';
}
