{ inputs, ... }:{
  flake-file.inputs.flake-aspects.url = "github:vic/flake-aspects";

  imports = [ inputs.flake-aspects.flakeModule ];
}
