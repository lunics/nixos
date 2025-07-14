{
  services.avahi = {
    enable   = false;
    nssmdns4 = true;
    publish  = {
      enable    = false;
      addresses = true;   
    }; 
  };
}
