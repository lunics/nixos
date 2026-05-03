{
  outputs = { self }:{
    nixosModules.system = import ./system/config;
  };
}
