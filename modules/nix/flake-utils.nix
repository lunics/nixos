{
  # no direct use: top-level input so omniflake and yt-x share a single flake-utils (auto-follow)
  flake-file.inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };
}
