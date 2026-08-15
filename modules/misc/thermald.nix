{
  flake.aspects.thermald.nixos = { config, pkgs, ... }:{
    services.thermald = {
      enable     = config._.cpu-max-temp != null;
      configFile = pkgs.writeText "thermal-conf.xml" ''
        <?xml version="1.0"?>
        <ThermalConfiguration>
          <Platform>
            <Name>cap package temperature</Name>
            <ProductName>*</ProductName>
            <Preference>QUIET</Preference>
            <ThermalZones>
              <ThermalZone>
                <Type>cpu</Type>
                <TripPoints>
                  <TripPoint>
                    <SensorType>x86_pkg_temp</SensorType>
                    <Temperature>${toString (config._.cpu-max-temp * 1000)}</Temperature>
                    <type>passive</type>
                    <ControlType>SEQUENTIAL</ControlType>
                    <CoolingDevice>
                      <index>1</index>
                      <type>rapl_controller</type>
                      <influence>100</influence>
                      <SamplingPeriod>1</SamplingPeriod>
                    </CoolingDevice>
                  </TripPoint>
                </TripPoints>
              </ThermalZone>
            </ThermalZones>
          </Platform>
        </ThermalConfiguration>
      '';
    };
  };
}
