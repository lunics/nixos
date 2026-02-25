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
    ./auto-save.nix
    
    ./render-markdown.nix
    # ./markdown-preview.nix

    ./noice.nix
    ./nvim-surround.nix
    ./commentary.nix
    ./numbertoggle.nix
  ];
}
