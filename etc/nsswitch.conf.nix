# KO ?
{ environment.etc."nsswitch.conf".text = "

passwd:    files systemd
group:     files [success=merge] systemd
shadow:    files
sudoers:   files

hosts:     files mdns4_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns mymachines
networks:  files

ethers:    files
services:  files
protocols: files
rpc:       files

";}
