{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    tigervnc
  ];

  xdg.configFile."tigervnc/default.tigervnc".text = ''
    TigerVNC Configuration file Version 1.0
    # https://tigervnc.org/doc/vncviewer.html
    
    ServerName=192.168.1.28
    SecurityTypes=None,VncAuth,RA2ne,RA2ne_256,Plain,DH,MSLogonII,TLSNone,TLSVnc,TLSPlain,X509None,X509Vnc,X509Plain,RA2,RA2_256
    FullScreen=on
    EmulateMiddleButton=on
    AlwaysCursor=on
    CursorType=System         # Dot, System
  '';
}
