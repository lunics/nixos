{
  outputs = { self }:{
    nixosModules.system = import ./modules;
  };
}
