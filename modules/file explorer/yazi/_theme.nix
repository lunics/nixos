{
  flake.aspects.yazi.homeManager = {
    home.file.".config/yazi/theme.toml".text = ''
      [status]
      bg = "none"

      [overall]
      bg = "none"
    '';
  };
}
