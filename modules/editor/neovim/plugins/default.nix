{
  imports = [
    ./highlight-undo.nix
    ./transparent.nix
    # ./smear-cursor.nix     KO with t key
    # ./treesitter.nix       KO synthax highlighting broken, and auto fold code

    ./bufferline.nix
    # ./lualine.nix         # KO build: lualine.nvim-scm-1.rockspec failed with hash
    # https://github.com/vim-airline/vim-airline/

    # ./telescope.nix
    ./fzf-lua.nix
    # ./yazi.nix

    ./flash.nix
    ./better-escape.nix
    ./neoscroll.nix

    ./lazygit.nix
    # ./trim.nix
    ./vim-obsession.nix               # modifies the session files to always autosave after sourcing.
    # ./auto-session.nix              # Automatically stores sessions in a shared directory
    # ./neovim-session-manager.nix    # Saves sessions and manages workspaces
    # ./project.nix         ## KO module 'project' not found
    ./workspaces.nix

    # ./plenary.nix                     # required by neovim-session-manager
    # ./auto-save.nix
    
    ./render-markdown.nix
    # ./markdown-preview.nix

    ./noice.nix
  ];

  plugins = {
    commentary.enable     = true;
    auto-save.enable      = true;
    nvim-surround.enable  = true;
    # spider.enable         = true;   # ?, KO build: lualine.nvim-scm-1.rockspec failed with hash
    numbertoggle.enable   = true;   # turn off relative number when buffer not focused
  };

  # yetone/avante nvim
  # { 'nvim-tree/nvim-web-devicons', },
  #   'nacro90/numb.nvim',
  # { 'svban/YankAssassin.vim', },
  # { 'tommcdo/vim-exchange', },
  # { 'jghauser/mkdir.nvim', },
  #   'willothy/flatten.nvim',
  #   'kana/vim-textobj-line',
  # https://github.com/akinsho/git-conflict.nvim/
  # folke/which-key.nvim',
  # toggleterm.nvim   manage multiple terminal windows
  # https://github.com/nat-418/boole.nvim
  # https://github.com/gerazov/toggle-bool.nvim
  # https://github.com/AckslD/nvim-neoclip.lua/
  #   age.nvim — Neovim utility for loading encrypted secrets.
  # https://github.com/pocco81/high-str.nvim
  #   To create on fly highlighting


# 2
  # { 'tpope/vim-abolish', },

# 3
# https://github.com/stevearc/aerial.nvim/
}
