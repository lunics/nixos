{
  outputs = { self }:{
    nixosModules.home = import ./modules;
  };
}
