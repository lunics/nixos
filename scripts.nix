{ ... }: let
  scripts = ./scripts/;   # must contains shell scripts
in {
  # Source scripts from the home-manager store
  home.file = {
    ".local/bin" = {
      recursive = true;
      source = "${scripts}";
    };
  };
}
