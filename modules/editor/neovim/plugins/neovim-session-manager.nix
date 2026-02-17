{ pkgs, ...}: {
  # A simple wrapper around :mksession

  ## REQUIRE plenary.nix

  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname    = "neovim-session-manager";
      version  = "2024-12-07";
      src      = pkgs.fetchFromGitHub {
        owner  = "Shatur";
        repo   = "neovim-session-manager";
        rev    = "ce43f2eb2a52492157d7742e5f684b9a42bb3e5c";
        sha256 = "sha256-W9jtfVXHC8MQJwdbxakNqhd+xh/auQb3U09XKdN2Wzw=";
      }; }) ];

  # extraConfigLua = ''
  #   require("smear_cursor").setup {
  #   }
  # '';
}
