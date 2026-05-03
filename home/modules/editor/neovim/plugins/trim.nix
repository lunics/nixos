{
  # https://github.com/cappyzawa/trim.nvim/

  plugins.trim.enable = true;

  extraConfigLua = ''
    require('trim').setup {
      ft_blocklist = {"markdown"},  -- to ignore markdown file.
      patterns = {
        [[%s/\(\n\n\)\n\+/\1/]],    -- to remove multiple blank lines, replace multiple blank lines with a single line
      },
      trim_on_write = false,        -- to disable trim on write by default
      highlight = true              -- highlight trailing spaces
    }
  '';
}
