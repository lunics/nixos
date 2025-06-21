{
  services.glances = {
    enable = true;
    customCSS = ''
      body, html {
        font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
      }
      .font-medium {
        font-weight: 700 !important;
      }
      .font-light {
        font-weight: 500 !important;
      }
      .font-thin {
        font-weight: 400 !important;
      }
      #information-widgets {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
      }
      div#footer {
        display: none;
      }
      .services-group.basis-full.flex-1.px-1.-my-1 {
        padding-bottom: 3rem;
      };
    '';
    settings = {
      layout = [
        {
          Glances = {
            header = false;
            style = "row";
            columns = 4;
          };
        }
        {
          Arr = {
            header = true;
            style = "column";
          };
        }
        {
          Downloads = {
            header = true;
            style = "column";
          };
        }
        {
          Media = {
            header = true;
            style = "column";
          };
        }
        {
          Services = {
            header = true;
            style = "column";
          };
        }
      ];
      headerStyle = "clean";
      statusStyle = "dot";
      hideVersion = "true";
    };
    services = [
      {
        Info = {
          widget = {
            type = "glances";
            url = "http://localhost:13989";
            metric = "info";
            chart = false;
            version = 4;
          };
        };
      }
      {
        "CPU Temp" = {
          widget = {
            type = "glances";
            url = "http://localhost:61378";
            metric = "sensor:Package id 0";
            chart = false;
            version = 4;
          };
        };
      }
      {
        Processes = {
          widget = {
            type = "glances";
            url = "http://localhost:61379";
            metric = "process";
            chart = false;
            version = 4;
          };
        };
      }
      {
        Network = {
          widget = {
            type = "glances";
            url = "http://localhost:61380";
            metric = "network:enp2s0";
            chart = false;
            version = 4;
          };
        };
      }
    ];
  };
}
