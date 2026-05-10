{
  flake.aspects.file_explorer.homeManager = {
    home.file.".config/yazi/theme.toml".text = ''
      [status]
      bg = "none"

      [overall]
      bg = "none"
    '';
  };
}
